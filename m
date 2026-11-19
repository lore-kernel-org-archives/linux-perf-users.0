Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078468;
	b=txoRn/EHGQ4pBgI7lsvauPV9A39JZ3W5hJzDMfkiqAFeWv5vIsT1l/WStONymVBGVTF7
	 b+nZlz1GwY1R94hhSufBKIEqCZrr6h6edaCWjZksBLqh4M5ru7BPW/cV4p33q2bR7GokC
	 OI0FBYNXxSLa9NYH7HnTnp5OjVtR/1uckrwsv3bSYdXf7aSVfYAMUoPjLaT77IYDPVQJY
	 Kf7CaFsjfcgAG4SxeW9y9SuUukSw5tBYNrRBoPrHdwEVHL1zzSQXYe3qBmB2Dx4of4oZu
	 U1C6U95SMV9RBQo/zaLTsGLLDvMy8m2jBsspKS5DvWqhc6R4MUCmmGoRfAazS4jmIGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078468;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=loH97Efk9dLDDTkm9svLgLvPkthPGP0mGuzEjGhs0Rc=;
	b=zl432BCoPXYwSDsJdTx9MDL79tGYRNQgUI7f/zPTZNZnZKlwmtyujYKysi5pZgVdHfTl
	 ND6X5g34h3EcRQVbZLuc/B0evCHsgwaQhYiIF2coXf2YzR+eNtnGxBOg0CtQ10hN7/LUi
	 3GiUvjhopVG+J9Wlfr6OPxXO0Z/D9y7zOdUZvpCuuqJ3wnNTNamNgP+gIrP5w/WDXTaTj
	 a4SMfZ/jyWhfzOmUL6c2qXNHrKnkIxa+tLQgRO2mbAMroLEqa4hlyuQzt5pq3uKbGEU7E
	 rTkMI5AediimzIOLvqsAjxgDRAeqeCHHJkL3MDdZMR3/6RR1VPthFWJkv9nv9vpYuwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DHwqRmdc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mc8zwV1E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B73606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 08:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B73606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DHwqRmdc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mc8zwV1E
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6wI6O1534962
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 08:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	loH97Efk9dLDDTkm9svLgLvPkthPGP0mGuzEjGhs0Rc=; b=DHwqRmdc4bLCjK4Q
	a8KDPCDbypmuJqtrITZ3djK1j2aCrAKdbMm5pmQEbwlizFGsSy6fROjERKzWLgcL
	K2yKeQmIM/AkZ3KXFb9FMVDdIJOece2QgoPTWjpRB3VUh67OuAGIFWAkglZWHAfZ
	6wlFGKI4hDz4seFFYAwznJpE5TlDlqc3+fJCBcfCSbxMmPLQhuKBbVpkLcdviBEt
	Ior7yYgdfYtiXcEoXSUX7bwo3mZv1cPPN8zPul1WAeR6o8HYaOC/D9Q1LBI+7dwa
	tsFTaDTZb+su+2jiRV9aqwSeksvi9E44y6fAsm7wVU4lDPG55sA5WNunWtW9rn4r
	5/ahIA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpcc9uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 08:54:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3c459a35eso2085072a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 00:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795078466; x=1795683266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loH97Efk9dLDDTkm9svLgLvPkthPGP0mGuzEjGhs0Rc=;
        b=Mc8zwV1E8hc5CQkn6eKo+4uwj546X1llsvhnsASADAPGk5JXPDMS33Pu9rGHaFV4o2
         q0FDiF9FwWlVj7TBUKvKXFFdEnVNpMuvgxuUfY+3USM7es659aTxG4Ty6W2brUy7BZxL
         7exQx23N0HQrruME/wxeVWgx+IPsp0JB7cn7eM6NqpfirWiMdszsRYvqx+HfoWz7dn8a
         gNd2pUbg35orNVQasj5L1MQUSRne702d8T5tWbyGS4/6v6JDluEoT5tGJmCZVKEFo4PJ
         K3SR30+2vnQlXZmTGBzpsNCQKwRCaVhG75LAFRNSgGcFFXxCkJX0vM+OiFuFPVtKYBiT
         Q3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795078466; x=1795683266;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=loH97Efk9dLDDTkm9svLgLvPkthPGP0mGuzEjGhs0Rc=;
        b=sC/9sxkjxdZA5UM9S07PdksHWz3QThIPFIgVOrciHt8cWlo8wl50q8FmijXiUSmp5I
         /o6Pt/Oo7Tp/W+UHwtxMQIFBTxtAoUYx5d/leOUkokx4Z+gRbdsnrbEgn3kpPEnyVq3Q
         aSXE4OxLndLX9VhW8ikvwXeWli/RwsyeLD4PD592sUmQIyNdyhIaWJ8jL/RzCdAEa36B
         VdNQVtvIvhU+o4SgQufc+4YTXhcWfzLMcveFOFLO3gNsiN65NmVVPY5Nb4Q2jKAlWeUg
         6DW+espl8wPNcXnaeQ6V8eyoUOojOWO4FHxdjt73b1GnlEHpFZlwrRKIizef3w+SlMkL
         Wmng==
X-Forwarded-Encrypted: i=1; AL+hErFCWlqusBP0K1E4hYrNowhsMk9ir5DeZ8L3aV0znkJie1Z56zFRqeLFs6hEaUuDGeMvooK1hVg/Qi6tkpiTe3RH@vger.kernel.org
X-Gm-Message-State: APuU4Z/M/FhFk8Te9/P+WlrsDsHtphZCT0qOgqZ5hCRsIAcgBwFehiv5
	VjKOf0nlaMi/bhe9F49/0vyaUAcJfTiNsJEOSAGogNdQdVYg7KUktmA1F5mDNr5PtJ2vHhd8zpM
	Zz08khPI4KtVLzJg+H+24jNR24uwRwg4WUoptcDD7QNT8qIbAmwNZV2GBYBnKNc1WJ3zFOwh6
X-Gm-Gg: AZFdTZf/5jRMDc504u+e5IQE8PQ0FI2HroJI7AwuI2y7kCPT5/dJHxJlrbwelmbbZDr
	vUge6kcI6AJQzQdMLm5l4qb5kbsde9TkCe5kROA5cnI5fOMyReQ2xgZitEgm2HgrsSJmV0NrhsZ
	g+jhvgptSU2pB7tSdDAZNCYR/NVTlnV1qyq7T3X3gtQtMnPR6lS4duLyYn/6tYtowXIbkE81rH9
	LZk5I/wV0J1wN497fjd5WItdm82DLXYuc59nzIJ3KN7p9H8THEG+K6rBPUmIjFrBY23iJ+u10oW
	yqqVu3heRN36ld9Kg8RfUjflrsylrz0ec4O7PXU18hrVMxgwm62ehubAp4Hr0Y9IGp5uOzv80lv
	oCNHwxD72LnJpt1tvb3YZr+ECPHejKnzxLX6GYEkzzAWVBlSqceug5a+B8J+DQ4aSP5qds4zVIt
	GjRnRCNw==
X-Received: by 2002:a17:90b:3d8f:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b3d07c687emr4589757a91.40.1795078465874;
        Thu, 19 Nov 2026 00:54:25 -0800 (PST)
X-Received: by 2002:a17:90b:3d8f:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b3d07c687emr4589724a91.40.1795078465152;
        Thu, 19 Nov 2026 00:54:25 -0800 (PST)
Received: from [10.218.24.187] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm1656162a91.16.2026.11.19.00.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 00:54:24 -0800 (PST)
Message-ID: <06758809-6748-4f7b-b7e6-c862936a961c@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 14:24:19 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: Reject group leaders detached by CPU hot-unplug
To: Daniel Wade <danjwade95@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>, Kyle Zeng <kylebot@openai.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261119014730.2074-1-danjwade95@gmail.com>
Content-Language: en-US
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
In-Reply-To: <20261119014730.2074-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afeb942 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=yrwFlzbl_MS6vLvGJOEA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX7zD0X+0ZGrAZ
 NYy31uKXwmPnPdT7Wm+4LV53ZE4VmR39jeRv2AJLP0gUxSraTEO6HVFyeiKVZC0IO505UvgI1c/
 jq1mUGUS4x3DYJHHSJynpeSAt+N1jkvhDTXxbAiNDCwDiAlOibEPtX53ecRQ19/I2ZwTIQnBOZ3
 fEPwkYJO40/T/gsWL5Y2DoFDgPgnBEVakFZj07AmP9bRRJrn7/vzRDjTzBnte4JZ9NAUJTJO4C8
 Pk5H2FtobtrJbFD8LByl/6nBQeSK+9Ync5uG6m2+Bvl3fLIPW5RafvdwlhyiKVWF65jE6S4ovQ/
 kfEZG2d1IprP6AiGxslLvGXWcVlGns97IGPlEBOw85+wOV5/V5xWjB6Fd1/8mnSdK2Bwb9o0QNn
 9nb9B7GiiztnmExvi9yp+/SLa310mN2F5G1taAaYcu+XzJFnoBkc7P9D4aKRnBkf1sbR0LCVVZt
 H5TDTTx4C2V14dDGclg==
X-Proofpoint-ORIG-GUID: sxIH43xNN21UD-FaCwGxof8F7JM887r0
X-Proofpoint-GUID: sxIH43xNN21UD-FaCwGxof8F7JM887r0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX8MxiJVbdoRzw
 hxnNtUJ5sJj58sLWS1fA9iLiTV9Iyaq3begKFLKiFMKQf3XS+tAvu+giy3O+p/Sp20loVOxr6Ri
 5hfDy022rJt/lQeP1zGcA4ZL7SK8F30=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190035

On 11/19/2026 7:17 AM, Daniel Wade wrote:
> CPU hot-unplug detaches the events of a CPU context but leaves them in
> OFF or ERROR, so once the CPU is back a detached leader is still accepted
> as group_fd. perf_group_detach() does nothing for a leader that is
> already detached, so closing it frees it with the new sibling still
> linked, and closing the sibling is a use-after-free.
> 
> Detach them with DETACH_EXIT as well, so that they end up in
> PERF_EVENT_STATE_EXIT and are rejected by the check from
> commit fa091f46c383 ("perf: Reject exited events as group leaders").
> 
> Side effect: poll() on a hot-unplugged event now reports EPOLLHUP, and it
> is refused as group_fd even with PERF_FLAG_FD_NO_GROUP.
> 
> Fixes: 226424eee809 ("perf: Fix corruption of sibling list with hotplug")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> v2: use DETACH_EXIT at hot-unplug instead of a new check, as Peter
> suggested.
> v1: https://lore.kernel.org/all/20261116081248.21059-1-danjwade95@gmail.com/
> 
> Tested on mainline b3dfbde62cf1, x86-64 with KASAN and PROVE_LOCKING,
> 2 vCPUs under KVM. Without the patch a sibling is accepted on a
> hot-unplugged leader and the close gives 15 KASAN reports. With it the
> open fails with ENODEV and no report appears.
> 
>  kernel/events/core.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f5f2261f1fe6..2de4c3cc37ac 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -15342,8 +15342,10 @@ static void __perf_event_exit_context(void *__info)
>  
>  	raw_spin_lock(&ctx->lock);
>  	ctx_sched_out(ctx, NULL, EVENT_TIME);
> -	list_for_each_entry(event, &ctx->event_list, event_entry)
> -		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
> +	list_for_each_entry(event, &ctx->event_list, event_entry) {
> +		__perf_remove_from_context(event, cpuctx, ctx,
> +					   (void *)(DETACH_EXIT | DETACH_GROUP));
> +	}
>  	raw_spin_unlock(&ctx->lock);
>  }

The patch itself LGTM.

Reviewed-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>

PatchWise AI code review (gpt-6-astra) flagged the following though:

[medium] Adding DETACH_EXIT makes is_event_hup() true, but this path never
wakes event->waitq. __perf_remove_from_context() changes the state and
detaches the event without calling perf_event_wakeup(), unlike
perf_event_exit_event(). A thread blocked in poll/epoll on a disabled,
mmap-backed CPU event can remain asleep indefinitely after CPU unplug,
even though a fresh poll reports EPOLLHUP. Arrange a wakeup in an
appropriate context after publishing the terminal state so existing
waiters receive the hangup indication.

--

To be clear, this is not a regression: before your patch these events went
to OFF and poll() never reported a hangup at all, so a waiter slept just
the same. But the EPOLLHUP the patch advertises does not reach tasks that
are already waiting:

                          task already asleep in poll()   a fresh poll()
  before your patch       stays asleep                    no data
  your patch              stays asleep                    EPOLLHUP
  your patch + wakeup     woken, sees EPOLLHUP            EPOLLHUP

perf_event_exit_event() kicks perf_poll() with perf_event_wakeup() after
moving events to EXIT, but this path doesn't, so a task already sleeping
in poll() is not woken and only sees EPOLLHUP when its timeout runs out.

Deferring the wakeup to the event's irq_work, as merge_sched_in() does,
seems enough. Something like this, on top of your patch:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c1f3e1f013ec..885b6594139a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15350,6 +15350,9 @@ static void __perf_event_exit_context(void *__info)
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		__perf_remove_from_context(event, cpuctx, ctx,
 					   (void *)(DETACH_EXIT | DETACH_GROUP));
+		/* Kick perf_poll() for is_event_hup(). */
+		event->pending_wakeup = 1;
+		irq_work_queue(&event->pending_irq);
 	}
 	raw_spin_unlock(&ctx->lock);
 }

Tested in a 4-CPU x86_64 QEMU/KVM guest (virtme-ng), 7.4.0-rc3+ with
lockdep enabled, using perf record -C 1 and then taking CPU 1 offline:

  perf record -C 1 -e cpu-clock -o /tmp/hp.data &
  echo 0 > /sys/devices/system/cpu/cpu1/online
  jobs
  perf report -i /tmp/hp.data --stdio | head

A) Your patch only. perf keeps running after the unplug and needs Ctrl-C:

  # perf record -C 1 -e cpu-clock -o /tmp/hp.data &
  [1] 149
  # echo 0 > /sys/devices/system/cpu/cpu1/online
  # jobs
  [1]+  Running                 perf record -C 1 -e cpu-clock -o /tmp/hp.data &
  # fg
  perf record -C 1 -e cpu-clock -o /tmp/hp.data
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.040 MB /tmp/hp.data (283 samples) ]
  # perf report -i /tmp/hp.data --stdio | head
  ...
  # Samples: 283  of event 'cpu-clock'
  # Event count (approx.): 70750000

B) Your patch plus the wakeup above. perf gets EPOLLHUP at once, flushes
   and exits by itself:

  # perf record -C 1 -e cpu-clock -o /tmp/hp.data &
  [1] 151
  # echo 0 > /sys/devices/system/cpu/cpu1/online
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.065 MB /tmp/hp.data (737 samples) ]

  [1]+  Done                    perf record -C 1 -e cpu-clock -o /tmp/hp.data
  # perf report -i /tmp/hp.data --stdio | head
  ...
  # Samples: 737  of event 'cpu-clock'
  # Event count (approx.): 184250000

Thank you,
Aditya

