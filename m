Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC14642B;
	Mon,  6 May 2024 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974189; cv=none; b=jExYLBRgz9QqeoFjcecRGaP0Ag9YdTilIzoUWV9dlxW3r9qIFxyP4MC224KAytpHqzbuoIP4NcyvNObpB2n/UhCc+kyovL0UBZ7QexfYjVLCBuyYJuiEvjsiu6uhIcUTz/YVTI/MgCSST3/3+ncBwtzoB+M61C9afAPV/Cg3iFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974189; c=relaxed/simple;
	bh=WMJHwSO3L59g5E5FDZOj42F0Mf3EVp1etLOrQhyekTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MNn4qKreq1hYxMsGozQ/zFO2FHtA1UMzGEuy2oPLW8PaFiufZNDDV+ich9bkC6h4ygdvrNGU4vsjsWx/JqXmoj9ZM0BjVvwLZbBNXRqGBuffyY4XT1Hct2fVRMlgkLJlisXwqSjuwY00rdoeRnuTui6My9NQpLlA7nsjtejyap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0cfVJZ+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0cfVJZ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714974187; x=1746510187;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=WMJHwSO3L59g5E5FDZOj42F0Mf3EVp1etLOrQhyekTg=;
  b=m0cfVJZ+BIkSPlYUnlHe9rmtlZkzg9P/LKNb8JTQEpak2rohXmK8LDQt
   Mcyd5ENIbxnIVVnEjnH0dw81LYb0QZT+wrIjvm62lR8UPRTQWouP+3rkR
   hf34b7UdnblXlsUcxObG/MDOSWr55C6MzFTgBOWuYldgoiDhOuzqsVtYs
   zI+7t7sd2IsRuXYa87Ifu5XvCPtayz6jsdmGUr8f3Qoe4xqOqayAaKvcl
   jFuPEx2ks8hoOKrqKaiGGWsV53ICuuj4BtefaH+DQioxhsLkIK6JkUOeU
   YdTesnxZ3GVbnhiidRR8hPbMy79LQO/X85SxDI+9ykIhxemVXD9CXTr75
   w==;
X-CSE-ConnectionGUID: 21OYnZfjTIuwn7n0657W3g==
X-CSE-MsgGUID: 5RoM3dOlTleEjmcJ/n7XhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10546379"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10546379"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 22:43:06 -0700
X-CSE-ConnectionGUID: 1Gd1gwXBQcu3UTXIobGjjQ==
X-CSE-MsgGUID: 4RPKVBRbQJCfYt462k1xhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59247291"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.32.241])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 22:43:03 -0700
Message-ID: <d47346fc-51b4-4af5-a014-0bd6f3b7bae0@intel.com>
Date: Mon, 6 May 2024 08:43:01 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf maps: Process kcore maps in order
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240505202805.583253-1-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240505202805.583253-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/05/24 23:28, Leo Yan wrote:
> On Arm64, after enabling the 'DEBUG=1' build option, the tool exits
> abnormally:
> 
>   # ./perf report --itrace=Zi10ibT
>   # perf: util/maps.c:42: check_invariants: Assertion `map__end(prev) <= map__start(map) || map__start(prev) == map__start(map)' failed.
>     Aborted
> 
> The details for causing this error are described in below.
> 
> Firstly, machine__get_running_kernel_start() calculates the delta
> between the '_stext' symbol and the '_edata' symbol for the kernel map,
> alongside with eBPF maps:
> 
>   DSO              | Start address      | End address
>   -----------------+--------------------+--------------------
>   kernel.kallsyms    0xffff800080000000   0xffff800082229200
>   bpf_prog           0xffff800082545aac   0xffff800082545c94
>   ...
> 
> Then, the perf tool retrieves kcore maps:
> 
>   Kcore maps       | Start address      | End address
>   -----------------+--------------------+--------------------
>   kcore_text         0xffff800080000000   0xffff8000822f0000
>   vmalloc            0xffff800080000000   0xfffffdffbf800000
>   ...
> 
> Finally, the function dso__load_kcore() extends the kernel maps based on
> the retrieved kcore info. Since it uses the inverted order for
> processing the kcore maps, it extends maps for the vmalloc region prior
> to the 'kcore_text' map:
> 
>   DSO              | Start address      | End address
>   -----------------+--------------------+--------------------
>   kernel.kallsyms    0xffff800080000000   0xffff800082229200
>   kernel.kallsyms    0xffff800082229200   0xffff800082545aac -> Extended for vmalloc region
>   bpf_prog           0xffff800082545aac   0xffff800082545c94
>   ...
> 
>   DSO              | Start address      | End address
>   -----------------+--------------------+--------------------
>   kernel.kallsyms    0xffff800080000000   0xffff8000822f0000 -> Updated for kcore_text map
>   kernel.kallsyms    0xffff800082229200   0xffff800082545aac
>   bpf_prog           0xffff800082545aac   0xffff800082545c94
>   ...
> 
> As result, the two maps [0xffff800080000000..0xffff8000822f0000) and
> [0xffff800082229200..0xffff800082545aac) are overlapping and triggers
> failure.
> 
> The current code processes kcore maps in inverted order. To fix it, this
> patch adds kcore maps in the tail of list, afterwards these maps will be
> processed in the order. Therefore, the kernel text section can be
> processed prior to handling the vmalloc region, which avoids using the
> inaccurate kernel text size when extending maps with the vmalloc region.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/symbol.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9ebdb8e13c0b..e15d70845488 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1266,7 +1266,24 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>  	map__set_end(list_node->map, map__start(list_node->map) + len);
>  	map__set_pgoff(list_node->map, pgoff);
>  
> -	list_add(&list_node->node, &md->maps);
> +	/*
> +	 * Kcore maps are ordered with:
> +	 *   [_text.._end): Kernel text section
> +	 *   [VMALLOC_START..VMALLOC_END): vmalloc
> +	 *   ...
> +	 *
> +	 * On Arm64, the '_text' and 'VMALLOC_START' are the same values
> +	 * but VMALLOC_END (~124TiB) is much bigger then the text end
> +	 * address. So '_text' region is the subset of the vmalloc region.
> +	 *
> +	 * Afterwards, when dso__load_kcore() adjusts kernel maps, we must
> +	 * process the kernel text size prior to handling vmalloc region.
> +	 * This can avoid to using any inaccurate kernel text size when
> +	 * extending maps with vmalloc region. For this reason, here it
> +	 * always adds kcore maps to the tail of list to make sure the
> +	 * sequential handling is in order.
> +	 */
> +	list_add_tail(&list_node->node, &md->maps);

This seems reasonable, but I wonder if it might be robust
and future proof to also process the main map first
e.g. totally untested:

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9ebdb8e13c0b..63bce45a5abb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1365,16 +1365,15 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (!replacement_map)
 		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
 
-	/* Add new maps */
+	/* Add replacement_map */
 	while (!list_empty(&md.maps)) {
 		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
 		struct map *new_map = new_node->map;
 
-		list_del_init(&new_node->node);
-
 		if (RC_CHK_EQUAL(new_map, replacement_map)) {
 			struct map *map_ref;
 
+			list_del_init(&new_node->node);
 			map__set_start(map, map__start(new_map));
 			map__set_end(map, map__end(new_map));
 			map__set_pgoff(map, map__pgoff(new_map));
@@ -1385,20 +1384,29 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			err = maps__insert(kmaps, map_ref);
 			map__put(map_ref);
 			map__put(new_map);
+			free(new_node);
 			if (err)
 				goto out_err;
-		} else {
-			/*
-			 * Merge kcore map into existing maps,
-			 * and ensure that current maps (eBPF)
-			 * stay intact.
-			 */
-			if (maps__merge_in(kmaps, new_map)) {
-				err = -EINVAL;
-				goto out_err;
-			}
 		}
+	}
+
+	/* Add new maps */
+	while (!list_empty(&md.maps)) {
+		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
+		struct map *new_map = new_node->map;
+
+		list_del_init(&new_node->node);
+
+		/*
+		 * Merge kcore map into existing maps,
+		 * and ensure that current maps (eBPF)
+		 * stay intact.
+		 */
+		if (maps__merge_in(kmaps, new_map))
+			err = -EINVAL;
 		free(new_node);
+		if (err)
+			goto out_err;
 	}
 
 	if (machine__is(machine, "x86_64")) {


