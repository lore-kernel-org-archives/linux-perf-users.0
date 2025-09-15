Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E422FFDF6
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933437; cv=none; b=AortxQ/bBZm4U3nkkTgn3ay33sYqSqy47E48d4i+8/bg8N4IUky4ys5rCzGu3qqeubnweuHauxNLhTZWWtPZOoy5/ifhpsySrG0JWZjrQ5cm115ZpeoxKC5YoSQEECN4+aw3VgJnYMzd1M5E8j7j52/sNSuYMsLwwtCeyPwZxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933437; c=relaxed/simple;
	bh=TXHetOHlkmlYD6PbgeijJZo+RaZULfGI+WWQUPe9uUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4ItpbI9WIjHu37FSYQkEHVanrgVI47AcLWxh7IOdTqnf/1XyLunirt8tz8ZZQYQB2JXm46GLFdM+2HGeERcGwDf6L74l2A1M5BPUL2JsFtf5hBdcyR+IDbeYW2G/CQ805ZCNrdT/KgHGyLm7D5xkJDoHObx8yMCam5PSMm1tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQM2p1Pc9z9sxY;
	Mon, 15 Sep 2025 12:38:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GczDd0MPrivs; Mon, 15 Sep 2025 12:38:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQM2p004Pz9sxX;
	Mon, 15 Sep 2025 12:38:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DC98C8B765;
	Mon, 15 Sep 2025 12:38:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id L12I9pCXFpTn; Mon, 15 Sep 2025 12:38:57 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A34148B763;
	Mon, 15 Sep 2025 12:38:57 +0200 (CEST)
Message-ID: <bc6c17d2-298b-4629-9de1-dcecc3aac58f@csgroup.eu>
Date: Mon, 15 Sep 2025 12:38:57 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] Add interface to expose vpa dtl counters via
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
 irogers@google.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org,
 aboorvad@linux.ibm.com, sshegde@linux.ibm.com, hbathini@linux.vnet.ibm.com,
 Aditya.Bodkhe1@ibm.com, venkat88@linux.ibm.com, Tejas.Manhas1@ibm.com,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
References: <20250915102947.26681-1-atrajeev@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250915102947.26681-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/09/2025 à 12:29, Athira Rajeev a écrit :
> The pseries Shared Processor Logical Partition(SPLPAR) machines can
> retrieve a log of dispatch and preempt events from the hypervisor
> using data from Disptach Trace Log(DTL) buffer. With this information,
> user can retrieve when and why each dispatch & preempt has occurred.
> The vpa-dtl PMU exposes the Virtual Processor Area(VPA) DTL counters
> via perf.
> 
> - Patches 1 to 6 has powerpc PMU driver code changes to capture DTL
>    trace in perf.data. And patch 7 has documentation update.
> 
> Infrastructure used
> ===================
> 
> The VPA DTL PMU counters do not interrupt on overflow or generate any
> PMI interrupts. Therefore, hrtimer is used to poll the DTL data. The timer
> nterval can be provided by user via sample_period field in nano seconds.
> vpa dtl pmu has one hrtimer added per vpa-dtl pmu thread. DTL (Dispatch
> Trace Log) contains information about dispatch/preempt, enqueue time etc.
> We directly copy the DTL buffer data as part of auxiliary buffer and it
> will be processed later. This will avoid time taken to create samples
> in the kernel space. The PMU driver collecting Dispatch Trace Log (DTL)
> entries makes use of AUX support in perf infrastructure. On the tools side,
> this data is made available as PERF_RECORD_AUXTRACE records.
> 
> To corelate each DTL entry with other events across CPU's, an auxtrace_queue
> is created for each CPU. Each auxtrace queue has a array/list of auxtrace buffers.
> All auxtrace queues is maintained in auxtrace heap. The queues are sorted
> based on timestamp. When the different PERF_RECORD_XX records are processed,
> compare the timestamp of perf record with timestamp of top element in the
> auxtrace heap so that DTL events can be co-related with other events
> Process the auxtrace queue if the timestamp of element from heap is
> lower than timestamp from entry in perf record. Sometimes it could happen that
> one buffer is only partially processed. if the timestamp of occurrence of
> another event is more than currently processed element in the queue, it will
> move on to next perf record. So keep track of position of buffer to continue
> processing next time. Update the timestamp of the auxtrace heap with the timestamp
> of last processed entry from the auxtrace buffer.
> 
> This infrastructure ensures dispatch trace log entries can be corelated
> and presented along with other events like sched.
> 
> With the kernel changes;
> 
>    # ls /sys/devices/vpa_dtl/
>    events  format  perf_event_mux_interval_ms  power  subsystem  type  uevent
> 
> Thanks
> Athira

What is the difference between this version of the series and the V2 
sent 3 hours ago ?

Christophe

