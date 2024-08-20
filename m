Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0186165EE1;
	Tue, 20 Aug 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186552; cv=none; b=oAfuxl+cTULZFLS0bLYhFIPnZn7+LgVMWwx3fHzhoSV/opRgvV5FzBCTJtkMBxFk7qI5vkuy+I/5o/RTaiHBMXpoMmuJnP2lZqBFgpJqC5l4//M13A7/nlchP3KRPUZ/4BJ/L/BBPE07xErTyBuk/NTw6aFHb0wxqI30FAC3FjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186552; c=relaxed/simple;
	bh=BVOerJkEHEr7Ozcu9FLEzXmnShEbjbpstZNKshq1GLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/L3JFOrOVO8x4kVCW6V7YRtsStVvRA9CHKs9YVw5T53J++vBKoUycrM+L5RpMOrbkJbEYvKCu9/LaeKipZGpgZaW2+cJDIX8NUQisX0GWOXe8sLj385n5B7ptzGW1e0lPPrw00ZXeyT49aPEy1rgatWtjU7P2nJtVl0y9LMhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLa3fGY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLa3fGY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05919C4AF0B;
	Tue, 20 Aug 2024 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724186551;
	bh=BVOerJkEHEr7Ozcu9FLEzXmnShEbjbpstZNKshq1GLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLa3fGY8hJ+aYG1aJjPl+JK9oAIVV9+fol053fCbnwxsDpkh/bEXOXNFly5dPo75c
	 a6qkWhT1F+zUpwP8xeV1qaalQ5AOh+m+6Fk/4TwAJ7zNzi5qzSu3Ioqz5NOE4c4e/9
	 Lq0I3yxBdvs7dXv8ZH3EwboIKX+91Jouf8QK7EOufgTHebdIV/VUDQuahbMVLnuuw9
	 49Nlx06WP1z5EJWv1Xm+Bb7FWm4WlBIA9YKrdkiLjth6zlqJp1hjOrjHPH1ekbBjNN
	 6L8iAY9LxBNB974kDrPkN3n0NPzX9Nw9/mgAyeDlUQmK6vlOuv/rnOcCwczXIarT/Y
	 kRP4t2ctKKmNA==
Date: Tue, 20 Aug 2024 17:42:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf annotate-data: Set bitfield member offset and size
 properly
Message-ID: <ZsT_tHyuwb8L3KVB@x1>
References: <20240815223823.2402285-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815223823.2402285-1-namhyung@kernel.org>

On Thu, Aug 15, 2024 at 03:38:23PM -0700, Namhyung Kim wrote:
> The bitfield members might not have DW_AT_data_member_location.  Let's
> use DW_AT_data_bit_offset to set the member offset correct.  Also use
> DW_AT_bit_size for the name like in a C program.

Thanks, applied and added the series of steps to reproduce your results:

    Commiter notes:
    
    Collect some data:
    
      root@number:~# perf mem record -a --ldlat 5 -- ping -s 8193 -f 192.168.86.1
      Memory events are enabled on a subset of CPUs: 16-27
      PING 192.168.86.1 (192.168.86.1) 8193(8221) bytes of data.
      .^C
      --- 192.168.86.1 ping statistics ---
      13881 packets transmitted, 13880 received, 0.00720409% packet loss, time 8664ms
      rtt min/avg/max/mdev = 0.510/0.599/7.768/0.115 ms, ipg/ewma 0.624/0.593 ms
      [ perf record: Woken up 8 times to write data ]
      [ perf record: Captured and wrote 14.877 MB perf.data (46785 samples) ]
    
      root@number:~#
      root@number:~# perf evlist
      cpu_atom/mem-loads,ldlat=5/P
      cpu_atom/mem-stores/P
      dummy:u
      root@number:~# perf evlist -v
      cpu_atom/mem-loads,ldlat=5/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x7
      cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
      dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|CPU|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
      root@number:~#
    
    Ok, now lets see what changes from before this patch to after it:
    
      root@number:~# perf annotate --data-type > /tmp/before
    
    Apply the patch, build:
    
      root@number:~# perf annotate --data-type > /tmp/after
    
    The first hunk of the diff, for a glib data structure, in userspace,
    look at those bitfields:
    
      root@number:~# diff -u10 /tmp/before /tmp/after | head -20
      --- /tmp/before       2024-08-20 17:29:58.306765780 -0300
      +++ /tmp/after        2024-08-20 17:33:13.210582596 -0300
      @@ -163,22 +163,22 @@
    
       Annotate type: 'GHashTable' in /usr/lib64/libglib-2.0.so.0.8000.3 (1 samples):
       ============================================================================
        Percent     offset       size  field
         100.00          0         96  GHashTable    {
           0.00          0          8      gsize    size;
           0.00          8          4      gint     mod;
         100.00         12          4      guint    mask;
           0.00         16          4      guint    nnodes;
           0.00         20          4      guint    noccupied;
      -    0.00          0          4      guint    have_big_keys;
      -    0.00          0          4      guint    have_big_values;
      +    0.00         24          1      guint    have_big_keys:1;
      +    0.00         24          1      guint    have_big_values:1;
           0.00         32          8      gpointer keys;
           0.00         40          8      guint*   hashes;
           0.00         48          8      gpointer values;
      root@number:~#
    
    As advertised :-)
    
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

