Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FD28D8DB;
	Fri,  6 Feb 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414663; cv=none; b=ApvCiuNwe7u2Qoov1l/Vs9hwp8x3JRUPSERrxDn68EXTBB2MfTWUmwF9pFfIrL7Q6wVMx1XEpOYOqNPsAdPrdLxu8YitmN3pqGVBYEjGKqDvMHQruB5dtuN22ImlL6tz9QsmrSFbDI0TQmdqGG7M7FKRP10bkdjPvyLobqOiQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414663; c=relaxed/simple;
	bh=o1sr+UYJnVIPirT1EzaiVfjrDMp4E8LMkahNFK48vX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH7BcsxoMur3KbjN1Dd2EBiEhBQeXqVyf4jrbJUDkNNo5t2pE3Lxe97ttNb2Z2OyCphhGEIw9C2CPb7JFByFbsbC8hlRXI/TqIrugb8v2yIt5c/jnsotslFvJCSBpdamwx5Q3eZYRl+GvS29cEC3F9An5zifiJue40+/4neCxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSm6DM68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSm6DM68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB5CC116C6;
	Fri,  6 Feb 2026 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770414662;
	bh=o1sr+UYJnVIPirT1EzaiVfjrDMp4E8LMkahNFK48vX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSm6DM685v+znffYKUCFCqiWPkwO/H2/wgVTGK4BsYMiEEAZ/KSYNedZr7lWXhMmL
	 bh1mEsK7HF2joZHLzgMVivw+OqlxfauLWsXQiv1emJE8g/Yw2SbmFFWfyw4n3ZE7HK
	 XjnTaN1d1+I3rZEDdyZk9MB6kudr69bpAbeQAJDWhm9kKMTF/+5EMtl9G3V+CbAogL
	 nEooqweW9BMTmIW3Vq689DbO45xt1jVAuEbch/argZwRHCwedJvwf3IUjE5Rfmk12E
	 JG6mrn1pPYZLj0SVdryuH3I2E+ZF+ckasNy22qsTjGKkkuVlDdwjkI51ysBB7le/nB
	 wARAKK1QW7YnQ==
Date: Fri, 6 Feb 2026 18:50:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: peterz@infradead.org, namhyung@kernel.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf utilities: Replace static cacheline size with
 sysconf cacheline size
Message-ID: <aYZiQk6Uftzlb_JV@x1>
References: <20260129004223.26799-1-ricky.ringler@proton.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129004223.26799-1-ricky.ringler@proton.me>

On Thu, Jan 29, 2026 at 12:42:27AM +0000, Ricky Ringler wrote:
> Testing:
> - Built perf
> - Executed perf mem record and report
> 
> Tested-by: Ricky Ringler <ricky.ringler@proton.me>
> 
> Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
> ---
>  tools/perf/util/sort.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f3a565b0e230..aa79eb6476dd 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2474,8 +2474,7 @@ struct sort_entry sort_type_offset = {
>  
>  /* --sort typecln */
>  
> -/* TODO: use actual value in the system */
> -#define TYPE_CACHELINE_SIZE  64
> +#define DEFAULT_CACHELINE_SIZE 64

I'm applying as this addresses the TODO and for cases where both record
and report/c2c are performed on the same machine it is an improvement,
but we need to actually get this from the perf.data header, because we
can collect in one machine with a cacheline size and then do the
report/c2c on another, with a different cacheline size.

When doing 'perf report --header-only -I' to see cache info we get
thingsl like:

# CPU cache info:
#  L1 Data                 48K [0,16]
#  L1 Instruction          32K [0,16]
#  L1 Data                 48K [1,17]
#  L1 Instruction          32K [1,17]
#  L1 Data                 48K [2,18]
#  L1 Instruction          32K [2,18]
#  L1 Data                 48K [3,19]
#  L1 Instruction          32K [3,19]
#  L1 Data                 48K [4,20]
#  L1 Instruction          32K [4,20]
#  L1 Data                 48K [5,21]
#  L1 Instruction          32K [5,21]
#  L1 Data                 48K [6,22]
#  L1 Instruction          32K [6,22]
#  L1 Data                 48K [7,23]
#  L1 Instruction          32K [7,23]
#  L1 Data                 48K [8,24]
#  L1 Instruction          32K [8,24]
#  L1 Data                 48K [9,25]
#  L1 Instruction          32K [9,25]
#  L1 Data                 48K [10,26]
#  L1 Instruction          32K [10,26]
#  L1 Data                 48K [11,27]
#  L1 Instruction          32K [11,27]
#  L1 Data                 48K [12,28]
#  L1 Instruction          32K [12,28]
#  L1 Data                 48K [13,29]
#  L1 Instruction          32K [13,29]
#  L1 Data                 48K [14,30]
#  L1 Instruction          32K [14,30]
#  L1 Data                 48K [15,31]
#  L1 Instruction          32K [15,31]
#  L2 Unified            1024K [0,16]
#  L2 Unified            1024K [1,17]
#  L2 Unified            1024K [2,18]
#  L2 Unified            1024K [3,19]
:

But not the cacheline size :-\

Please consider adding this header info :-)

Applied.

- Arnaldo
  
>  static int64_t
>  sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
> @@ -2484,6 +2483,10 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
>  	struct annotated_data_type *right_type = right->mem_type;
>  	int64_t left_cln, right_cln;
>  	int64_t ret;
> +	int cln_size = cacheline_size();
> +
> +	if (cln_size == 0)
> +		cln_size = DEFAULT_CACHELINE_SIZE;
>  
>  	if (!left_type) {
>  		sort__type_init(left);
> @@ -2499,8 +2502,8 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
>  	if (ret)
>  		return ret;
>  
> -	left_cln = left->mem_type_off / TYPE_CACHELINE_SIZE;
> -	right_cln = right->mem_type_off / TYPE_CACHELINE_SIZE;
> +	left_cln = left->mem_type_off / cln_size;
> +	right_cln = right->mem_type_off / cln_size;
>  	return left_cln - right_cln;
>  }
>  
> @@ -2508,9 +2511,13 @@ static int hist_entry__typecln_snprintf(struct hist_entry *he, char *bf,
>  				     size_t size, unsigned int width __maybe_unused)
>  {
>  	struct annotated_data_type *he_type = he->mem_type;
> +	int cln_size = cacheline_size();
> +
> +	if (cln_size == 0)
> +		cln_size = DEFAULT_CACHELINE_SIZE;
>  
>  	return repsep_snprintf(bf, size, "%s: cache-line %d", he_type->self.type_name,
> -			       he->mem_type_off / TYPE_CACHELINE_SIZE);
> +			       he->mem_type_off / cln_size);
>  }
>  
>  struct sort_entry sort_type_cacheline = {
> -- 
> 2.52.0
> 
