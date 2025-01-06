Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9811E0B80;
	Mon,  6 Jan 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198125; cv=none; b=tv7qD5U1ldXj93rbncboOaOYnken01SBxk5goWg3dj8o8atkCxJQ+fVeuWIhLK5LWQagJfmj+rZGYeHUFkVdOcp3bgvYOnJrkkLogFGjN/6DbnrU33n4gSnViVPuaePTfITP6laKieMwDHx7HaXMy+kInWxZZVUCy92Fz/ETXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198125; c=relaxed/simple;
	bh=IlUoArd3cgICxTGfsWTXC+9GlSm6A1FG5iyMIObahC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1vhSgRetZr0orTbKSSEJI7o0XkK7D67vcs0gLeExzl1WgKg1z53Jk6egFGP1/K8iORp4rZa+QPSerwdPXOJjQ89mJDpzjlZo/c5EVdMeGOoRrYU/5InRSaqEI0n1P+FwUJBASdGDOM87j4abdkrpOH3I9V+lek9JfYlsRNdsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwGagPV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwGagPV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D953C4CED2;
	Mon,  6 Jan 2025 21:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736198124;
	bh=IlUoArd3cgICxTGfsWTXC+9GlSm6A1FG5iyMIObahC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwGagPV4zLkJa5iQxsPetExJbd2Anx2BZkFgd93Zg9A4i6J9V03AAp8GtT14zgXy2
	 fBqK0+rm6zyUhARLe6/oaTN6y6IG2Tx4SnBSir04ItlTfdwGBC4CDH+SdWQ4gJes3G
	 RWpAEPrAHGH2dn6sFTadTjz2L05Reo9/6n9tF4MiWFiPE2E1o4EqHKfXIKLh/+LwEH
	 DDIPupJY7U0qRZ8It5lESknB8k/g0b9GSyCEldvE9FFg5Iuu5Wsd2z7SYmDsT4PZGy
	 QxwjJcWjzNkX1ypXCbxL8VnuyLlPPSBt1i0f+CE9zrJ4wR8Gftrz0Q0U1T9DiRmVe5
	 ZJMUtFO1VYqIQ==
Date: Mon, 6 Jan 2025 13:15:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] tools/perf: Fix return code for lock_contention_prepare
Message-ID: <Z3xH6kCK9zj5ttZM@google.com>
References: <20241223135655.8042-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241223135655.8042-1-atrajeev@linux.vnet.ibm.com>

Hello,

On Mon, Dec 23, 2024 at 07:26:55PM +0530, Athira Rajeev wrote:
> perf lock contention returns zero exit value even if the lock contention
> BPF setup failed.
> 
>    # ./perf lock con -b true
>    libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>    libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
>    libbpf: failed to find valid kernel BTF
>    libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>    libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
>    libbpf: failed to find valid kernel BTF
>    libbpf: Error loading vmlinux BTF: -ESRCH
>    libbpf: failed to load object 'lock_contention_bpf'
>    libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
>    Failed to load lock-contention BPF skeleton
>    lock contention BPF setup failed
>    # echo $?
>     0
> 
> Fix this by saving the return code for lock_contention_prepare
> so that command exits with proper return code
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks for the fix, the change itself looks good but I think we need the
same for setup_output_field() and select_key() as well.

Thanks,
Namhyung


> ---
>  tools/perf/builtin-lock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 208c482daa56..2226c7dd4ae6 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2049,7 +2049,8 @@ static int __cmd_contention(int argc, const char **argv)
>  				goto out_delete;
>  		}
>  
> -		if (lock_contention_prepare(&con) < 0) {
> +		err = lock_contention_prepare(&con);
> +		if (err < 0) {
>  			pr_err("lock contention BPF setup failed\n");
>  			goto out_delete;
>  		}
> -- 
> 2.43.5
> 
