Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385E18508E
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392974; cv=none; b=P8kOXdZT6OYdj98QNSRrYLTx0HTwmI15S+F7tX7mx5uEHF/ruBk6rZ3vhhV3cTGodlu867b5GhtfuR6c3BP11YH0y54X4/ihGbXosmn3nhiwJDWniM/DhRNn6ilP8Trbk8qUwKbGh9tAsU3+K/ToP/Xo3+C1LCrHPLf2gJAZ6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392974; c=relaxed/simple;
	bh=a39sUM3zov78QnUlDrhjyXSKxHd2k85FHP/Q1J7MDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2qKspVKrhGJPYFMH0GO9b/KkhH/2no9GvNyx5vxz0GJJ9vP8LvCKNLp3ngejM7ia6Y4TBczweAR/5cKVVqKCRifUQ8zshddjnRUBYdUH1Ot2sxVLOV8laq2duoYItywa57m4pzNnoH79SZVVM5Al+kGIZwehFAowolqjSPyGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzQvUHpT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzQvUHpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719392972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yxabqjPXuaehC+Jnq82ty6138Ii/bMpqB1bgyXKMiPM=;
	b=dzQvUHpTquCmPgQk5cW79zqu9ndCiyhXl51T9uAoDDFv6DHhyrGyBdkk8WuARNyH7f3bUD
	i9dffcsQsMTyfM/mUhbbQePiJ9hcdJ1fWdQiuRb1qxi3z7jyWqdji1gqFQYdNTMjCW7mYq
	IOVWgGcDyp1NC5Pbm3dFrmg5Bc5MGoI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-cyQURnZzO5-7PpBTpqNyWw-1; Wed,
 26 Jun 2024 05:09:30 -0400
X-MC-Unique: cyQURnZzO5-7PpBTpqNyWw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21A3C19560B3;
	Wed, 26 Jun 2024 09:09:29 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.183])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7E2D19560BF;
	Wed, 26 Jun 2024 09:09:27 +0000 (UTC)
Date: Wed, 26 Jun 2024 11:09:24 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Fix perf script -F +metric
Message-ID: <20240626090924.GA56952@alecto.usersys.redhat.com>
References: <20240625004232.1852705-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625004232.1852705-1-ak@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jun 24, 2024 at 05:42:31PM -0700, Andi Kleen wrote:
> This fixes a regression with perf script -F +metric originally caused by :
>
> commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
> Author: Ian Rogers <irogers@google.com>
> Date:   Sun Feb 19 01:28:46 2023 -0800
>
>     perf metric: Directly use counts rather than saved_value
>
> In the perf script environment the evsel wouldn't allocate an aggr
> values array, which led to a -1 reference because the metric
> evaluation would try to reference NULL - 1 (for aggr_idx)
>
> Give the perf script evsels a single CPU aggr setup. That's
> enough because the groups are always contiguous, so no need
> to store more than one CPU's worth of values.
>
> Before
>
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> % perf script -F +metric
> Segmentation fault (core dumped)
>
> After:
>
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> ...
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
> % perf script -F +metric
>        perf-exec 1847557 264658.180789:       3009       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
>        perf-exec 1847557 264658.180789:        382 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
>        perf-exec 1847557 264658.180789:         metric:    0.13  insn per cycle
> ...
>
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

This works, however there seems to be yet another issue on
perf-tools-next branch that breaks script metrics.

617824a7f0f73 (perf parse-events: Prefer sysfs/JSON hardware
events over legacy, 2024-04-15) changes event priority so on
my host "instructions" have type PERF_TYPE_RAW instead of
PERF_TYPE_HARDWARE.

# event : name = instructions, , id = { 190969, 190970, 190971, 190972, 190973, 190974, 190975, 190976 }, type = 4 (cpu), size = 136, config = 0xc0 (instructions), sample_type = IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER, read_format = ID|GROUP|LOST, sample_id_all = 1, exclude_guest = 1

This results in evsel__stat_type no longer recognizing these as
STAT_INSTRUCTIONS.

> ---
>  tools/perf/builtin-script.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..4aab194b4b1a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -84,7 +84,7 @@ static bool			system_wide;
>  static bool			print_flags;
>  static const char		*cpu_list;
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> -static struct perf_stat_config	stat_config;
> +static struct perf_stat_config	stat_config = { .aggr_map = &(struct cpu_aggr_map){ .nr = 1 } };
>  static int			max_blocks;
>  static bool			native_arch;
>  static struct dlfilter		*dlfilter;
> @@ -2133,12 +2133,14 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  	if (evsel_script(leader)->gnum++ == 0)
>  		perf_stat__reset_shadow_stats();
>  	val = sample->period * evsel->scale;
> +	/* Always use CPU 0 storage because the groups are contiguous. */
> +	evsel->stats->aggr[0].counts.val = val;
>  	evsel_script(evsel)->val = val;
>  	if (evsel_script(leader)->gnum == leader->core.nr_members) {
>  		for_each_group_member (ev2, leader) {
>  			perf_stat__print_shadow_stats(&stat_config, ev2,
>  						      evsel_script(ev2)->val,
> -						      sample->cpu,
> +						      0,
>  						      &ctx,
>  						      NULL);
>  		}
> --
> 2.45.2
>

--
 Artem

