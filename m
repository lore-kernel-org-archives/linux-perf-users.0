Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C414825B6
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049663; cv=none; b=lvU8AHQrfb6Wh1PL2JxddmL2jUmm9TN9JPNrPdk43hfMhAtr0xdvMnUpmFkhLiky5S7M0O37iG00wgOvskD/fQloUNJYphp++X751WcAMW1u58HWBYduCddgmb7PNQHZiqQgE3VFXiSVoVzvW3ieJ+O0XpPmJrZsDNIJgf0o8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049663; c=relaxed/simple;
	bh=4bQNC6lE1ZF18pYa66ru3uWTmhHYMAK6YT+D0+1HApg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWAvy7nRyPq7RtsXE7Jo3OaO1Yf0UjZ29NYwdj+ykpePc8UoybsQHBVeQrtoRTpxYpU0Serp/g73LbzZORirFZtIePp8CJa5s4Q3Nyuf+ij8CVQd9OwFf6dJH2mxb9ju/7pG4Hn4lZa87fyOf/tLmDx1/nUn/0mJinHaHXWNLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX3pMVRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX3pMVRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5C31F000FF;
	Thu, 10 Sep 2026 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049662;
	bh=kc6nWLdvtrAQTHZv9+Dw08iBJzQCT8XITYFstRn/IjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KX3pMVRpf9gJvfMKVjRcH+nsIs5p2KojpdclYRBDZdY6UZIEmOfFfHbbrsXXNxZVp
	 yzZQoHtzqSHTDL1QVXTQ3w5jkSbTUk0AbFoSDozqLCEBqXl7hz2pLXdkIkekKA2UQ4
	 0NKBs5mPaiFtKlITWQascB9TBy8mL/ejPf3eetDV1rKA21N3N+NzLc0R1KgbG2jt0W
	 Save/cJfiQ1kdWfPzqtwiN/uzgMkJA8/JrgYon8Hfl8FyPt9VppYrjpA40IUFIShoG
	 DVFLV9bl3/mvgooX9qHIHLFW4xdsVsrqsH1oa+XA2AAKunJBktXtNA4C/zQitp/326
	 LkvDMwip3q7Tg==
Date: Thu, 10 Sep 2026 11:14:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: MANNURU VENKATESWARLU <v-mannuru@ti.com>
Cc: peterz@infradead.org, mingo@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, n-francis@ti.com, s-k6@ti.com,
	bb@ti.com
Subject: Re: [RFC PATCH 17/22] perf/events: arm64: ti: Add J7 DDR performance
 events
Message-ID: <aqK7OprV6Pe8xrtZ@x2>
References: <20260714125635.3304437-1-v-mannuru@ti.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714125635.3304437-1-v-mannuru@ti.com>

On Tue, Jul 14, 2026 at 06:26:30PM +0530, MANNURU VENKATESWARLU wrote:
> Add perf JSON event and metric definitions for the J7 family
> DDR controller PMU covering J721E, J721S2, J7200 and J784S4.

Can someone from ARM please take a look at this and provide some
Reviewed-by?

Thanks,

- Arnaldo
 
> Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
> ---
>  .../pmu-events/arch/arm64/ti/j7/sys/ddrc.json | 240 ++++++++++++++++++
>  .../arch/arm64/ti/j7/sys/metrics.json         |  34 +++
>  2 files changed, 274 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json
> new file mode 100644
> index 0000000000000..7ed64c25500d4
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json
> @@ -0,0 +1,240 @@
> +[
> +   {
> +       "BriefDescription": "Counts every Write command",
> +       "EventCode": "0x00",
> +       "EventName": "k3_ddr.write",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Read command",
> +       "EventCode": "0x01",
> +       "EventName": "k3_ddr.read",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every read as a result of a RMW command",
> +       "EventCode": "0x02",
> +       "EventName": "k3_ddr.read_rmw",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Activate command",
> +       "EventCode": "0x03",
> +       "EventName": "k3_ddr.activate",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Precharge command",
> +       "EventCode": "0x04",
> +       "EventName": "k3_ddr.precharge",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Precharge All command",
> +       "EventCode": "0x05",
> +       "EventName": "k3_ddr.precharge_all",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Mode Register Read command",
> +       "EventCode": "0x06",
> +       "EventName": "k3_ddr.mode_reg_read",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Mode Register Write command",
> +       "EventCode": "0x07",
> +       "EventName": "k3_ddr.mode_reg_write",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Per Bank Refresh command",
> +       "EventCode": "0x08",
> +       "EventName": "k3_ddr.per_bank_refresh",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Auto Refresh command",
> +       "EventCode": "0x09",
> +       "EventName": "k3_ddr.auto_refresh",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every ZQ Calib Long command",
> +       "EventCode": "0x0a",
> +       "EventName": "k3_ddr.zq_calib_long",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every ZQ Calib Short command",
> +       "EventCode": "0x0b",
> +       "EventName": "k3_ddr.zq_calib_short",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Write-to-Read and Read-to-Write bus-turn-around",
> +       "EventCode": "0x0c",
> +       "EventName": "k3_ddr.bus_turn_around",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Write-to-Write address collision",
> +       "EventCode": "0x0d",
> +       "EventName": "k3_ddr.write_write_collision",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Write-to-Read address collision",
> +       "EventCode": "0x0e",
> +       "EventName": "k3_ddr.write_read_collision",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Read-to-Write address collision",
> +       "EventCode": "0x0f",
> +       "EventName": "k3_ddr.read_write_collision",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every Read-to-Read address collision",
> +       "EventCode": "0x10",
> +       "EventName": "k3_ddr.read_read_collision",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every exit from Power-Down Self-Refresh mode",
> +       "EventCode": "0x11",
> +       "EventName": "k3_ddr.exit_power_down_self_refresh",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every entry into Power-Down Self-Refresh mode",
> +       "EventCode": "0x12",
> +       "EventName": "k3_ddr.entry_power_down_self_refresh",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down Self-Refresh mode",
> +       "EventCode": "0x13",
> +       "EventName": "k3_ddr.power_down_self_refresh_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every exit from Power-Down mode",
> +       "EventCode": "0x14",
> +       "EventName": "k3_ddr.exit_power_down",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every entry into Power-Down mode",
> +       "EventCode": "0x15",
> +       "EventName": "k3_ddr.entry_power_down",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down mode",
> +       "EventCode": "0x16",
> +       "EventName": "k3_ddr.power_down_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every exit from Self-Refresh mode",
> +       "EventCode": "0x17",
> +       "EventName": "k3_ddr.exit_self_refresh",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every entry into Self-Refresh mode",
> +       "EventCode": "0x18",
> +       "EventName": "k3_ddr.entry_self_refresh",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Self-Refresh mode",
> +       "EventCode": "0x19",
> +       "EventName": "k3_ddr.self_refresh_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller command queue is full",
> +       "EventCode": "0x1c",
> +       "EventName": "k3_ddr.command_queue_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller info FIFO is full",
> +       "EventCode": "0x1d",
> +       "EventName": "k3_ddr.info_fifo_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller write latency FIFO is full",
> +       "EventCode": "0x1e",
> +       "EventName": "k3_ddr.write_latency_fifo_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller port command FIFO is full",
> +       "EventCode": "0x1f",
> +       "EventName": "k3_ddr.port_command_fifo_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller write response FIFO is full",
> +       "EventCode": "0x20",
> +       "EventName": "k3_ddr.write_response_fifo_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller port write FIFO is full",
> +       "EventCode": "0x21",
> +       "EventName": "k3_ddr.port_write_fifo_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller core read FIFO is full",
> +       "EventCode": "0x22",
> +       "EventName": "k3_ddr.core_read_fifo_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   },
> +   {
> +       "BriefDescription": "Counts every cycle for which the DDR Controller port read FIFO is full",
> +       "EventCode": "0x23",
> +       "EventName": "k3_ddr.port_read_fifo_full_cycles",
> +       "Unit": "k3_ddr",
> +       "Compat": "J7"
> +   }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json
> new file mode 100644
> index 0000000000000..156b2c9dec185
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json
> @@ -0,0 +1,34 @@
> +[
> +    {
> +        "BriefDescription": "DDR memory read bandwidth in MB/s (32-bit bus, BL16)",
> +        "MetricExpr": "(k3_ddr.read * 64) / (duration_time * 1e6)",
> +        "MetricGroup": "ddr",
> +        "MetricName": "k3_ddr_j7.read_bandwidth_mbytes_sec",
> +        "ScaleUnit": "1MB/s",
> +        "Compat": "J7"
> +    },
> +    {
> +        "BriefDescription": "DDR memory write bandwidth in MB/s (32-bit bus, BL16)",
> +        "MetricExpr": "(k3_ddr.write * 64) / (duration_time * 1e6)",
> +        "MetricGroup": "ddr",
> +        "MetricName": "k3_ddr_j7.write_bandwidth_mbytes_sec",
> +        "ScaleUnit": "1MB/s",
> +        "Compat": "J7"
> +    },
> +    {
> +        "BriefDescription": "Average DDR read requests per second",
> +        "MetricExpr": "k3_ddr.read / duration_time",
> +        "MetricGroup": "ddr",
> +        "MetricName": "k3_ddr_j7.read_requests_per_sec",
> +        "ScaleUnit": "1reads/sec",
> +        "Compat": "J7"
> +    },
> +    {
> +        "BriefDescription": "Average DDR write requests per second",
> +        "MetricExpr": "k3_ddr.write / duration_time",
> +        "MetricGroup": "ddr",
> +        "MetricName": "k3_ddr_j7.write_requests_per_sec",
> +        "ScaleUnit": "1writes/sec",
> +        "Compat": "J7"
> +    }
> +]
> -- 
> 2.34.1
