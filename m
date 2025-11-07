Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB1248F64;
	Fri,  7 Nov 2025 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481803; cv=none; b=AP5NtModzklvqSSMQR+QcLQdyIvNLDGwSiJifnWRo8sVJNFe7YogETzRkI1FwIN8G+Wu5V2ZaVZrn3G5enaV7tiQANzsvxT192R6aXHBEaDm+dhvFmjONURHRrchDANflxoNRGVYs0AeLwNYNrT4uofEwZjUU7XHU3ojcTzNvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481803; c=relaxed/simple;
	bh=bMJDqvaeAKGKv7h2LPGCCibx6LwxLovMeMKDzrJTLhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzCAPpIdDroLf5MerL4mAIkngDqoZYFA15rD3gQRzjUMGkCjt7YFLcrLW+c0TTxT73IWikRtttT6OkuZp10kf0EkBdezpYDndy4uAMxPzorRvq0GfttkNIq2Mkd+lbOdgyo82F/79mt2N2p8dzVHm1NChd6DwG08mdCaG+bxuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn//ome2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn//ome2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309A7C4AF0B;
	Fri,  7 Nov 2025 02:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762481803;
	bh=bMJDqvaeAKGKv7h2LPGCCibx6LwxLovMeMKDzrJTLhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kn//ome2xnLCw6HhTnpK6eIhstQH2Mn3/lrtur3X1RFMydBjaMqeh1Em+mbGwujwC
	 pbSjLPVz77+hCC5AzumGC5cMn8wkX3/rA7Jc8wjwkqAn41bnoI2WUXXYpTzM7Wt3gD
	 vxOF9fP6kdSDO4NuWfBNoBmVOI5XKZgiMnJBUUZ2aeEDueI2EXwdU7th8aolHMSbJx
	 olfFhzNr2w+U3ExviI9fVLSb0Fw0fR5g+cro6p7bhwkHEuTvIb4PaYOjyBmO9mxzU6
	 Erqr2Pzgg36dMOqMXgo9BF2yObtmoURV9xKdz29NgMNhJO9iZZSCt+pvOEAp58inK5
	 qdkq8TC0wBDJw==
Date: Thu, 6 Nov 2025 18:16:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 1/5] perf jitdump: Fix PID namespace detection
Message-ID: <aQ1WiC3Id82pTHAI@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
 <20251105191626.34998-2-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105191626.34998-2-iii@linux.ibm.com>

On Wed, Nov 05, 2025 at 08:10:24PM +0100, Ilya Leoshkevich wrote:
> perf inject fails to detect jitdump file produced by a process
> running in a different PID namespace if this process has not exited
> yet.
> 
> The PID namespace heuristic in jit_detect() compares two PIDs:
> 
> * pid: outermost NStgid of mmap(jitdump) caller from perf's PoV.
> * nsinfo__nstgid(nsi): innermost NStgid of mmap(jitdump) caller from
>                        perf's PoV.
> 
> The semantics of the in_pidns variable can be seen in, e.g.,
> nsinfo__get_nspid(): it's true if and only if perf and the profiled
> process are in different PID namespaces.
> 
> The current logic is clearly inverted: if pid and nsinfo__nstgid(nsi)
> are different, then the profiled process must be in a different PID
> namespace. This, of course, ignores that fact that they may end up
> being equal by accident, but that's not the point here.
> 
> Fix by flipping the comparison.
> 
> Changing just that, however, breaks the case when the process has
> exited. Add explicit support for that by adding "synthesized" field to
> nsinfo, which tracks whether NStgid was obtained from a running
> process (ignoring considerations of PID reuse or running inject on
> a different machine). When the namespace information is synthesized,
> assume the process ran in a different PID namespace.

I'm not sure I'm following.  It'd be great if anyone understand the
topic well could review.

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/perf/util/jitdump.c    | 27 +++++++++++++++++++++------
>  tools/perf/util/namespaces.c |  9 +++++++++
>  tools/perf/util/namespaces.h |  2 ++
>  3 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index b062b1f234b62..19e4bc139935b 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -788,15 +788,30 @@ jit_detect(const char *mmap_name, pid_t pid, struct nsinfo *nsi, bool *in_pidns)
>  	if (!end)
>  		return -1;
>  
> -	*in_pidns = pid == nsinfo__nstgid(nsi);
>  	/*
> -	 * pid does not match mmap pid
> -	 * pid==0 in system-wide mode (synthesized)
> +	 * Determine whether the process ran inside a container, and whether it
> +	 * mapped jit.dump for profiling purposes or by accident. Record this
> +	 * for further use in jit_inject(). The kernel does not provide PID
> +	 * namespace information, so we have to resort to guesswork.
>  	 *
> -	 * If the pid in the file name is equal to the nstgid, then
> -	 * the agent ran inside a container and perf outside the
> -	 * container, so record it for further use in jit_inject().
> +	 * If the process exited and perf had to synthesize the namespace
> +	 * information, then it's not possible to have any certainty; be
> +	 * aggressive and assume that the process ran inside a container. This
> +	 * allows the user to proceed with injection at the cost of a small
> +	 * probability of injecting irrelevant data.
> +	 *
> +	 * If the process' NStgid as observed by perf is different from its
> +	 * innermost NStgid, then it must have run inside a container. There is
> +	 * a very small probability that NStgids randomly happenned to be the
> +	 * same; ignore it.
> +	 *
> +	 * pid == 0 means system-wide mode, just proceed.
> +	 *
> +	 * Finally, the most straightforward case: if the PID in the file name
> +	 * is equal to the process' NStgid as observed by perf, then it must be
> +	 * a match.
>  	 */
> +	*in_pidns = nsinfo__synthesized(nsi) || pid != nsinfo__nstgid(nsi);
>  	if (pid && !(pid2 == pid || *in_pidns))
>  		return -1;
>  	/*
> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index 01502570b32d0..7de5d62e271c4 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c
> @@ -132,6 +132,8 @@ int nsinfo__init(struct nsinfo *nsi)
>  
>  	rv = nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->nstgid,
>  			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
> +	if (rv == 0)
> +		RC_CHK_ACCESS(nsi)->synthesized = false;
>  
>  out:
>  	free(newns);
> @@ -166,6 +168,7 @@ struct nsinfo *nsinfo__new(pid_t pid)
>  	RC_CHK_ACCESS(nsi)->nstgid = pid;
>  	nsinfo__clear_need_setns(nsi);
>  	RC_CHK_ACCESS(nsi)->in_pidns = false;
> +	RC_CHK_ACCESS(nsi)->synthesized = true;
>  	/* Init may fail if the process exits while we're trying to look at its
>  	 * proc information. In that case, save the pid but don't try to enter
>  	 * the namespace.
> @@ -197,6 +200,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
>  	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
>  	RC_CHK_ACCESS(nnsi)->need_setns = nsinfo__need_setns(nsi);
>  	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
> +	RC_CHK_ACCESS(nnsi)->synthesized = nsinfo__synthesized(nsi);
>  	if (nsinfo__mntns_path(nsi)) {
>  		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(nsinfo__mntns_path(nsi));
>  		if (!RC_CHK_ACCESS(nnsi)->mntns_path) {
> @@ -275,6 +279,11 @@ void nsinfo__set_in_pidns(struct nsinfo *nsi)
>  	RC_CHK_ACCESS(nsi)->in_pidns = true;
>  }
>  
> +bool nsinfo__synthesized(const struct nsinfo *nsi)
> +{
> +	return RC_CHK_ACCESS(nsi)->synthesized;
> +}
> +
>  void nsinfo__mountns_enter(struct nsinfo *nsi,
>  				  struct nscookie *nc)
>  {
> diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
> index e95c79b80e27c..41ba2ea8137e5 100644
> --- a/tools/perf/util/namespaces.h
> +++ b/tools/perf/util/namespaces.h
> @@ -38,6 +38,7 @@ DECLARE_RC_STRUCT(nsinfo) {
>  	bool			in_pidns;
>  	char			*mntns_path;
>  	refcount_t		refcnt;
> +	bool			synthesized;

It'd be nice if you can put this along with other bool fields.

Thanks,
Namhyung

>  };
>  
>  struct nscookie {
> @@ -60,6 +61,7 @@ pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
>  pid_t nsinfo__pid(const struct nsinfo  *nsi);
>  bool nsinfo__in_pidns(const struct nsinfo  *nsi);
>  void nsinfo__set_in_pidns(struct nsinfo *nsi);
> +bool nsinfo__synthesized(const struct nsinfo  *nsi);
>  
>  void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
>  void nsinfo__mountns_exit(struct nscookie *nc);
> -- 
> 2.51.1
> 
