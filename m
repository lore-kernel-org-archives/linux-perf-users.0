Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E833F8A6
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137041; cv=none; b=fNqskcCWdGU3FhlplEIh/9WXqV+YhHeEFPpQAa/Pe2yvNMVngBbrkGvy2/eXBvdfB1IwEuZYBLaQbnf55ynZIfKq67DxmctG3b2EbGZYYR2jNu6L0WJECb9ti9Rwjz8LKfw8A5zUdGkyUPHmCFyA9B+iRxrgOFD/Bs8zO/4b150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137041; c=relaxed/simple;
	bh=woqTZAZo11aPYODRoXP7lQZLkvlvXuPi7JFoob2TO/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heN/bffUjWx72mAoxAoEc5lp82jpr372Ac1lUMfITox4LhdtJ9cD570wtzfM7nq3TVgwSb0cEQBmO/4w240mPiq4L2/IgSRWVQo1MCpjt/vsJOYrrU+FnHegx8iacls1NvT9xGMjx4CeY+Y1OEuCw7ULqUOTVkPYS7Z9JX5OoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZEmbwmEf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gSSpcRcI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZEmbwmEf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSSpcRcI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3iSdT1590634
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 04:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+J2xpeAMKYpKEJxmYGHEa7BvFvz/p/SUGur09udFCSA=; b=ZEmbwmEf+WEThC93
	e55GfHkvUnCvlSo3/qI9vkuKW9l3qd0hKcK3B9M4tAUYwXpoVVBCf5W4l0NfsjOK
	1jzLmkvVJx5TljTuL7jHslPUlMx1MgFrDrifnjU0ABK/ekgx9drguN7xRql7F6xf
	Kd/TBo7cbIfmZvi7eOnvG+u8cYivl+BkofKydAQPeG8UxAOluNB5DRBatw38vl29
	Pwa0rYfUu5yhPGbmortDhHLkCcBUOJs97CLQWbMwvqL/jYM72PUImFMwcQnPlqfS
	s5RZjwvltpQNjOk4REa5YdZTOCKac4PKB9uzol+hPmOoPstcsiUll4Epboeo+C0z
	6PmfFQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurntcc0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 04:17:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-334f782d1abso1564975eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 21:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790137037; x=1790741837; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+J2xpeAMKYpKEJxmYGHEa7BvFvz/p/SUGur09udFCSA=;
        b=gSSpcRcIjJ3nuwJ7rqzF6VwHRDWX828bdeU30MNwTrEpXYam6fXFg5HpzzcxTBThvi
         aRWCx6wUkHDonXTqzIyzI1oUYb4g9jMRXnFg/sF0+b4p5He5SPkxHPnOGAtZyKNkgRWl
         3SGaqYv72EmohoSvVjns/9OdchoaoFQr2pWWCfeGZQoq5iAipD8n2BmhN8rzIZxaRMFf
         CB2H+euvfKztpNXqBgy+EsAMAfs0f7sqd2XM81lvf7CpGICSNfeuZQgIy27FIsZXn2Vd
         2QPxyYYzcH/6TTpT0MoTertiVdGBAhnNs4RbH2bzX7VFG/iFspk/Q2X5U67fUHJEFl2v
         PLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790137037; x=1790741837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+J2xpeAMKYpKEJxmYGHEa7BvFvz/p/SUGur09udFCSA=;
        b=NOs1WVOmdWVurEnX5f5AvjeLSWJ/2nuiLUjrqbfmiJ6ZgF3E6dxEONMfLprRYey2Cp
         3FX+cFZv4cYXxn4omsoS2kabbka6MPCS5zIlxMri8hv4GGiqAd1k0O91y5iWTvKr41IL
         q9Zie8udpKqNj1B+RXyHgx6PY8mSeSHMus8zrguvRbxJ6ZkUQxdOFmZ7yq1jBvbil0bW
         HupoNCWy01ulIqT8EbWOhuKptmdew00AKjoZPpXZA9js8kW7E0da8jvMnGMJv08gOJCp
         bGQ8qpdcMBJqqt8XrEd/+mDEC8zULRE1MDwWBBr8gr9eCnvONOz0UJVF3qthiVnx15/X
         7UNA==
X-Forwarded-Encrypted: i=1; AKwUvBy5R51tL7hbkfNSSMmIkQADSpiXmkUkybxq/uXtNgUErWdcJZOP5XeUxpW13YRyp3OVwXcg7gt6OYNXs8BiOqgM@vger.kernel.org
X-Gm-Message-State: AFuF++kTE+SVPJ9/RAX46LHltf1LHY8oGkCWxVud2+NZ+o2OTBxge12S
	JtVTiRImOjOWu/cr/s59b9krRWKX5OaLIAfRfoJwBZ34nXBAPfAnsFPOe4OfUUhmlUmSbKHww+0
	ZyBxSowrVGcmjh2a9YY1vJV3MpuSQUgedgOMtWBYVK5ZB7S6d69f9Wj9xyOK6Jo5FIkx3W0O8
X-Gm-Gg: AYBFou3w24fcl7buqI/hrXfKgE5pyZy+ipQ/lCRmtfILqnVhoxbTEFmf+XRadSHacJk
	n7xWZMJrRXtvSDBH5HzI3x/oDCuDXq/NejD4yBmynMCkHptAT8mHZdQIwLVGD4m35NJhwAUIoAj
	m+9g77fWfAM5/Y0i1n6qOzI0rAIJ8+VZz6005jVTvy+25JVMiOYtI278s3LJWvw3G8r+bpOb0/A
	VMJ0zRJqzMY0PxmQ/0ELw9mxD3SAzxi6SAFLMJgXoD5/5e5Ban07lY2SyOKQdNdy2WIW9Vq8keF
	+ESzF//qyy5NWfPjtTVUNVkCliEPsgsZTmL+G99C5b1ci6UAg9u2Uv+dyzmidnt4bTz7a6D2jpE
	d0phQmuKrC+qdKn/bRi/3YnhJwJ36r2lnZTH0fmWyMtdcJIAQgMNXedEkd0gIqme7ENPHr6k4IL
	X8C3VmTzRHOodrBEcC1rAHRtQX
X-Received: by 2002:a05:7300:8242:b0:33b:db21:9877 with SMTP id 5a478bee46e88-33e8d9cd464mr1262711eec.20.1790137037148;
        Tue, 22 Sep 2026 21:17:17 -0700 (PDT)
X-Received: by 2002:a05:7300:8242:b0:33b:db21:9877 with SMTP id 5a478bee46e88-33e8d9cd464mr1262639eec.20.1790137036072;
        Tue, 22 Sep 2026 21:17:16 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm2589749eec.12.2026.09.22.21.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 21:17:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:47:03 +0530
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor@kernel.org>, Anup Patel <anup@brainfault.org>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Atish Patra <atish.patra@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
        Yuanzhu <yuanzhu@bytedance.com>,
        Yicong Yang <yang.yicong@picoheart.com>,
        Susheng Yang <yang.susheng@zte.com.cn>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 RESEND 0/9] riscv: add SBI Supervisor Software Events
 support
Message-ID: <arNSv4MT44XlaU8a@hu-himchau-blr.qualcomm.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
X-Proofpoint-ORIG-GUID: 3YozwVVb9fmCefsjJNXC2E6eBVOkVj4K
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab352ce cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=h0uksLzaAAAA:8 a=HwFc7jivAAAA:8
 a=NEAV23lmAAAA:8 a=FYjnu1bn2S_ONmW01JwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=MSi_79tMYmZZG2gvAgS0:22 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxNiBTYWx0ZWRfX+gBZbxGFLrwt
 jtgbTChUtWKuxDiyI6EhLiYiDy0KXHn8mZuXXNZhkHwsdk40qy5qU636RMMEcERGX51Y8s6TEGf
 eUCuPjWiQoJTavG64ZcD8NAjbXh8YM6JmApt3/c815qn6sWXvZTcE34RV2l6FSIMFR68X1g0zL8
 +bhbLSe3jCWHJy+J4D+7SPwcM+4nL01xdjtSpGlLbqH9Xr5Hhrxa+laN8jW2+IsHekb4vDRdElq
 XJgbb/1Lj3NnAwvepkvp69vBYE1Kx0BO+qa/dxHEVEdHucAY5f02af6hWeRvpaG4doVMdS87S9U
 kbJTV5KCMOlAbOUWwCQdQiGOSpN55dx+cIdvmzuJtbdzqSZ3zlO6032DaniCxptrJ4HjSueWtUq
 vUI8qFwZMiusGsFZr3kTI9TZi9SUFNSrNkG6prJpfDuhRAcQesmzTH8nL3kmyNrt3IrcDl4Ujp9
 EqjTgYPJF6N8o9vAPEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxNiBTYWx0ZWRfX/FXvX2kH+XVQ
 5PkJvjbnpOtUoderV598/15ILi7DEMejo50r6Q9psWe/Wk3WVW6gI8dN04yWyoTxu7ofybxJFk8
 ae44UemNWhatz32v6aIHNWSF/eg1Y5k=
X-Proofpoint-GUID: 3YozwVVb9fmCefsjJNXC2E6eBVOkVj4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230016

On Mon, Sep 21, 2026 at 07:14:57PM +0800, Zhanpeng Zhang wrote:
> This is v10 rebased onto v7.3-rc4, as a base for the RAS work requested
> by Himanshu. No additional fixes or features are included.
>
Thanks for this! This patch series sees a lot of churn. My patches don't
directly apply. Give me sometime to review and test.

Regards
Himanshu
 
> Only patch 7 needed adaptation: keep the upstream counter-mask bitmap
> conversion and snapshot NULL-check ordering, and adapt the SSE stop-all
> helper and early counter-mask initialization to the bitmap representation.
> The fast-only GUP user-stack copy remains unchanged.
> 
> Rebase validation: RV64 defconfig with SSE, PMU-SSE, CPU PM and kexec
> enabled builds Image, modules, the SSE test module and the user-stack
> selftest. The SSE, trap, fault and PMU objects also build for RV32.
> The exported series applies cleanly to v7.3-rc4 and reproduces the branch
> tree. On EVB247, the Debian-packaged rc4 kernel boots via kexec with its
> matching initrd and modules. The SSE framework and priority tests, all four
> stress layers in stress=1, and both user-stack selftests pass. The latter
> includes 32 concurrent samplers. No new kernel errors were observed.
> Unavailable injection events were skipped by the framework test; KVM was
> disabled in this test configuration, so virtualization was not retested.
> 
> The functional results below are retained from the original v10 and are
> not claims of runtime validation on this rebased kernel.
> 
> RISC-V does not architecturally define a supervisor-mode non-maskable
> interrupt (NMI). An interrupt that arrives while Linux has cleared SIE stays
> pending and is not observed until interrupts are enabled again. That is
> correct for ordinary interrupt handling, but some kernel work needs an
> NMI-like notification that can run even inside an interrupt-disabled region:
> sampling a PMU overflow at the instruction that caused it, or taking a
> high-priority RAS report promptly, cannot wait for the next unmask boundary.
> 
> The SBI Supervisor Software Events (SSE) extension [1] fills this gap. It lets
> Linux register handlers for events that the SBI implementation can deliver
> ahead of ordinary traps and interrupts, giving RISC-V the NMI-like supervisor
> notification mechanism it otherwise lacks.
> 
> SSE can carry several event sources: high-priority RAS reports, double traps,
> and PMU overflow, with room for further standard and platform events. This
> series focuses on PMU overflow, its first user. Delivering overflows through
> SSE lets perf sample the code that was actually running while interrupts were
> disabled, rather than the later point where execution reached an
> interrupt-unmask boundary.
> 
> This series implements the Linux side of that interface: the architecture
> entry machinery, a firmware driver that exposes SSE events to in-kernel
> clients, PMU overflow delivery, and regression tests. Per-hart local events
> and system-wide global events share one client API.
> 
> SSE delivery model
> ==================
> 
> Linux first registers a handler and an event stack with the SBI
> implementation, then enables the event. When an event source is signalled, the
> M-mode SBI implementation preempts Linux even in an interrupt-disabled region:
> it saves the interrupted supervisor state and constructs an S-mode context
> that enters the registered handler. Linux can now run its own handler, for
> example to take a perf sample or process a RAS report, then completes the
> event with another SBI call, allowing the interrupted context to resume.
> 
> The typical hardware-triggered delivery flow is (software-injected events skip
> the hardware trigger):
> 
>        <--------- Linux kernel ----------->  <-- Firmware --->  <- Hardware ->
>      interrupted context  SSE handler             OpenSBI          Hardware
>               |                 |                    |                 |
> [1] setup     |                 |-register & enable-->                 |
>               |                 |                    |                 |
> [2] trigger   |                 |                    <----trigger------|
>               |                 |                    |                 |
> [3] save      |                 |            +--------------+          |
>               |                 |            | context save |          |
>               |                 |            +--------------+          |
>               |                 |                    |                 |
> [4] inject    |                 |        +-----------------------+     |
>               |                 |        | handler context setup |     |
>               |                 |        +-----------------------+     |
>               |                 <---inject (mret) ---|                 |
>               |                 |                    |                 |
> [5] handle    |        +----------------+            |                 |
>               |        | event handling |            |                 |
>               |        +----------------+            |                 |
>               |                 |                    |                 |
> [6] complete  |                 |-----complete------->                 |
>               |                 |                    |                 |
> [7] restore   |                 |           +-----------------+        |
>               |                 |           | context restore |        |
>               |                 |           +-----------------+        |
>               |                 |                    |                 |
> [8] resume    <------------resume (mret) ------------|                 |
>               |                 |                    |                 |
> 
> The context used to enter the handler exists only for this handoff; it is not
> the task context that the event interrupted. The architecture entry code joins
> the two sides: it moves execution onto the event's dedicated stack and shadow
> call stack, establishes the current task, and presents the interrupted
> registers to the callback as a normal pt_regs. Clients can therefore operate
> on the original interrupted context without depending on the firmware entry
> details.
> 
> Linux implementation
> ====================
> 
> An SSE handler runs in NMI-like context: it must not sleep, must not take a
> page fault, and may interrupt code that holds arbitrary locks or is partway
> through kernel entry. The implementation is shaped by those constraints.
> 
> Because it is NMI-like, an SSE can arrive at any point where interrupts are
> disabled, including while Linux is midway through exception entry, a task
> switch, or a KVM guest transition, where the normal kernel entry state is only
> partially established. The SSE entry wrapper (the architecture assembly that
> runs before the client callback) copes with this: it preserves Linux-owned
> stvec, hstatus, and task stack metadata across the handler and any nested
> exception, and its earliest instructions, which run before the event stack and
> current task are set up, are kept outside kprobe instrumentation.
> 
> The callback receives the interrupted registers as a pt_regs and is allowed to
> edit them. On RISC-V a6 and a7 carry SBI call arguments and results, so a
> callback that wants to influence an in-flight SBI call the event interrupted
> edits them there. The entry wrapper copies just a6 and a7 from that pt_regs
> back into the context handed to the completion SBI call, so the edit takes
> effect when the interrupted code resumes; the rest of the interrupted state is
> restored by firmware and left untouched.
> 
> The firmware driver maps the SBI event state machine onto kernel resource
> ownership. A callback, stack, and attribute buffer stay alive until firmware
> has removed every registration that can refer to them. Failed partial
> operations remain tracked for later cleanup, an aborted CPU-offline operation
> restores the requested event state, and shutdown and kexec mask SSE before
> Linux stops servicing handlers.
> 
> PMU overflow and perf
> =====================
> 
> The RISC-V SBI PMU driver delivers overflows through ordinary interrupts by
> default. When firmware implements SSE and the local PMU-overflow event, the
> driver routes overflows through SSE instead. The choice is made once at setup
> and is not switched at runtime; an operational failure disables sampling
> rather than risking two active routes for the same overflow.
> 
> This changes where perf can observe an overflow, not how applications use
> perf. A normal PMU interrupt raised while S-mode interrupts are masked is
> handled only once they are enabled again, so the resulting sample often points
> at the unmask boundary rather than at the code that consumed the cycles. SSE
> can enter Linux at the original point and remove that source of sampling bias.
> No new perf option or perf.data format is introduced.
> 
> The entry code supplies the interrupted pt_regs needed for register samples
> and for kernel and user callchains. DWARF callchains additionally require a
> copy of the interrupted user stack. Since an SSE handler cannot take a normal
> page fault, this series takes a temporary reference to the resident user pages
> with fast-only GUP, copies them through their kernel mappings, and truncates
> the sample at the first page that is not immediately available. The existing
> in-atomic copy remains unchanged outside SSE context.
> 
> The PMU integration retains perf's throttling and stopped-event semantics. It
> restarts only runnable counters and orders the CPU power-management callbacks
> so that counters cannot resume after a hart has failed to restore its SSE
> delivery path.
> 
> Hardware results
> ================
> 
> We measured this on a RISC-V server platform. The same kernel source
> and perf binary were used for both routes; one delivered PMU overflows through
> ordinary interrupts and the other through SSE. The table shows the mean of
> three runs of three million single-CPU "perf bench sched pipe" operations. The
> "ops/s" columns are workload throughput (higher is better, so they show the
> profiling overhead); the "samples/s" columns are the sampling rate perf
> actually achieved against the requested -F frequency:
> 
>   rate       IRQ ops/s   SSE ops/s   delta   IRQ samples/s   SSE samples/s
>   -F 99        337,707     339,555   +0.55%            98.0            98.6
>   -F 999       338,352     338,289   -0.02%           995.7           998.0
>   -F 5000      329,002     333,034   +1.23%          5001.7          5001.6
> 
> There were no lost samples. Across these normal frequency settings, both
> delivery modes reached the requested sample rate and workload throughput
> differed by no more than 1.23%.
> 
> The "perf bench sched pipe" workload also shows why the delivery mechanism
> matters to the resulting profile. Ordinary PMU interrupts cannot enter an
> interrupt-disabled kernel critical section. Overflows raised there remain
> pending until interrupts are enabled again. Samples consequently accumulate
> at the enable boundary rather than at the code that consumed the cycles. In
> the IRQ profile, finish_task_switch() and _raw_spin_unlock_irqrestore()
> therefore accounted for 54.99% of all samples.
> 
> SSE can enter Linux while S-mode interrupts are disabled. The PMU-SSE
> profile therefore samples inside those critical sections and exposes the
> scheduler, locking, address-space switching, and wake-up paths doing the
> actual work. The leading entries from the two -F 999 reports show the
> difference.
> 
> With ordinary PMU interrupt delivery:
> 
>   overhead   symbol
>     36.63%   finish_task_switch.isra.0
>     18.36%   _raw_spin_unlock_irqrestore
>      7.66%   __internal_syscall_cancel
>      7.55%   do_trap_ecall_u
>      4.19%   mutex_lock
>      3.64%   mutex_unlock
>      3.06%   exit_to_user_mode_loop
> 
> With PMU-SSE delivery:
> 
>   overhead   symbol
>      5.48%   __kprobes_text_end
>      5.29%   __schedule
>      5.10%   ret_from_exception
>      4.71%   do_raw_spin_lock
>      4.01%   do_trap_ecall_u
>      3.99%   mutex_lock
>      3.66%   switch_mm
>      3.43%   mutex_unlock
>      3.29%   exit_to_user_mode_loop
>      3.28%   psi_group_change
> 
> The ordinary interrupt profile is dominated by two interrupt-enable
> boundaries. With SSE, those two entries account for only 3.37%. The samples
> are instead distributed across scheduler paths within the critical sections.
> 
> At perf's configured limit of 100,000 samples per second, both routes still
> made progress without lost samples. In this deliberately saturated regime SSE
> reduced workload throughput by 2.7% to 5.8%, which exposes the additional
> firmware-entry cost and marks a practical upper boundary for sampling.
> Thirty-second perf top runs at the same rate each processed about 3.1 million
> samples with no loss, stalls, or kernel failures.
> 
> The DWARF callchain path gets dedicated coverage because it was the source of
> the corruption this series fixes. On the same platform,
> "perf record -a -g --call-graph dwarf,512 -F 999" layered on a concurrent
> "hackbench -g25 -l600" -- the configuration that previously corrupted
> spinlocks and mutexes under SSE -- now completes cleanly, with no lost
> samples, lockups, RCU stalls, or faults, including a 431-iteration soak.
> Patch 9 adds a regression test that drives the non-faulting user-stack copy
> through the SSE handler with 32 concurrent samplers and checks perf's
> truncation semantics.
> 
> Changes in this resend
> ======================
> 
> This resend only rebases v10 onto v7.3-rc4. The only merge conflict was
> in patch 7, due to the upstream PMU counter-mask bitmap conversion.
> In v11, I will address the Sashiko review feedback and improve user-stack
> copying with an NMI-safe interface similar to x86's copy_from_user_nmi().
> 
> Changes in v10
> ==============
> 
> V10 turns the earlier feature series into a path suitable for sustained perf
> use. In particular, it:
> 
>   - reconstructs and publishes the interrupted context for perf register
>     samples and kernel and user callchains;
>   - preserves current, task stack metadata, stvec, hstatus, and shadow-call
>     stack state across synthetic entry and nested exceptions;
>   - prevents fault-disabled accesses from entering the generic RISC-V page
>     fault path and provides a non-faulting SSE user-stack copy;
>   - makes event lifetime and rollback explicit across partial firmware
>     operations, CPU hotplug, shutdown, crash, and kexec;
>   - closes PMU throttle, counter restart, CPU power-management, and cleanup
>     races without adding a runtime SSE-to-IRQ transition; and
>   - expands the framework stress coverage and adds a regression test for
>     high-frequency DWARF user-stack sampling.
> 
> Changes in v9:
>   - Rebased the original series onto RISC-V for-next.
>   - Preserved Linux-owned trap, virtualization, and supervisor state across
>     the synthetic SSE handler.
>   - Added framework stress modes and updated MAINTAINERS.
> 
> Previous versions:
>   v9:
>     https://lore.kernel.org/r/cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com
>   v8:
>     https://lore.kernel.org/r/20251105082639.342973-1-cleger@rivosinc.com
> 
> How to test
> ===========
> 
> Enable the SSE framework and SSE overflow delivery:
> 
>   CONFIG_RISCV_SBI_SSE=y
>   CONFIG_RISCV_PMU_SBI=y
>   CONFIG_RISCV_PMU_SBI_SSE=y
> 
> PMU-SSE also requires two OpenSBI fixes:
> 
>   f30a54f3b3a0 ("lib: sbi: pmu: Remove MIP clearing from pmu_sse_enable()")
>     [2], included since OpenSBI v1.7,
>     which keeps an overflow pending while its SSE event is temporarily
>     disabled; and
>   35511bc6ee1c ("lib: sbi: sse: clear SPV for non-virtualized events") [3],
>     not yet included in a tagged release,
>     which stops a stale HSTATUS.SPV from being applied to a non-virtualized
>     event.
> 
> Build tools/testing/selftests/riscv, then run:
> 
>   for stress in 0 1 2; do
>           ./run_sse_test.sh stress=$stress || break
>   done
>   ./sse_perf_ustack
> 
> Useful perf regression workloads include:
> 
>   perf record -e cycles -a -- sleep 1
>   perf top
>   perf record -g -F 999 -- hackbench
>   perf record --call-graph dwarf,8192 -F 999 -- hackbench
>   perf record -a -C 3 -e cycles -F 999 -- \
>           taskset -c 3 perf bench sched pipe -l 3000000
> 
> Limitations and follow-up work
> ==============================
> 
> This series does not yet deliver SSE events into a guest or unwind a guest
> stack; a later KVM-SSE series will let the host receive an event from firmware
> and inject the corresponding event into the guest.
> 
> Hibernation and crash kernels are unsupported: the current SBI interface
> cannot reconstruct firmware registrations after an image is restored, and a
> crash kernel cannot take over the registrations left by the crashed kernel, so
> it leaves SSE masked.
> 
> [1] https://docs.riscv.org/reference/sbi/ext-sse.html
> [2] https://github.com/riscv-software-src/opensbi/commit/f30a54f3b3a091c225a00476f4039bf399badd1f
> [3] https://github.com/riscv-software-src/opensbi/commit/35511bc6ee1c9c17b6a89b44c52e2044bb51b979
> 
> Acknowledgements
> ================
> 
> The original five feature patches were developed by Clément Léger and
> Himanshu Chauhan. Thanks to Susheng Yang for reporting the perf callchain
> failure and for providing a workload that made it reproducible.
> 
> Sorry for keeping you waiting. Since v9 I spent a good deal of time hardening
> the lifecycle and error paths and reproducing and analysing the bugs that only
> show up in the callchain path, until the series finally passed both functional
> and sustained stress testing on hardware. I am confident in v10, but, echoing
> Clément, SSE is a genuinely complex feature: it adds a new NMI-like entry path
> into the kernel to stand in for a hardware NMI. I would therefore welcome wider
> community testing and feedback, especially under high-frequency delivery and
> more complex handlers.
> 
> ---
> 
> Clément Léger (5):
>   riscv: add SBI SSE extension definitions
>   riscv: add support for SBI Supervisor Software Events extension
>   drivers: firmware: add riscv SSE support
>   perf: RISC-V: add support for SSE event
>   selftests/riscv: add SSE test module
> 
> Zhanpeng Zhang (4):
>   riscv: sse: mask events during shutdown and kexec
>   riscv: mm: avoid enabling interrupts for nofault page faults
>   perf: RISC-V: support callchains with SSE delivery
>   selftests/riscv: add perf user-stack SSE copy regression test
> 
>  Documentation/arch/riscv/index.rst            |    1 +
>  Documentation/arch/riscv/pmu-sse.rst          |   55 +
>  MAINTAINERS                                   |   22 +
>  arch/riscv/include/asm/asm.h                  |   14 +-
>  arch/riscv/include/asm/perf_event.h           |   10 +
>  arch/riscv/include/asm/sbi.h                  |   63 +
>  arch/riscv/include/asm/scs.h                  |    7 +
>  arch/riscv/include/asm/sse.h                  |   82 ++
>  arch/riscv/include/asm/thread_info.h          |    1 +
>  arch/riscv/kernel/Makefile                    |    1 +
>  arch/riscv/kernel/asm-offsets.c               |   14 +
>  arch/riscv/kernel/entry.S                     |   14 +
>  arch/riscv/kernel/machine_kexec.c             |   11 +
>  arch/riscv/kernel/perf_callchain.c            |  142 ++
>  arch/riscv/kernel/reset.c                     |   18 +
>  arch/riscv/kernel/sbi_sse.c                   |  246 ++++
>  arch/riscv/kernel/sbi_sse_entry.S             |  226 +++
>  arch/riscv/kernel/smp.c                       |   17 +
>  arch/riscv/mm/fault.c                         |   11 +-
>  drivers/firmware/Kconfig                      |    1 +
>  drivers/firmware/Makefile                     |    1 +
>  drivers/firmware/riscv/Kconfig                |   18 +
>  drivers/firmware/riscv/Makefile               |    3 +
>  drivers/firmware/riscv/riscv_sbi_sse.c        | 1228 +++++++++++++++++
>  drivers/perf/Kconfig                          |   11 +
>  drivers/perf/riscv_pmu.c                      |   14 +-
>  drivers/perf/riscv_pmu_sbi.c                  |  540 ++++++--
>  include/linux/cpuhotplug.h                    |    1 +
>  include/linux/perf/riscv_pmu.h                |   20 +-
>  include/linux/riscv_sbi_sse.h                 |   95 ++
>  tools/testing/selftests/riscv/Makefile        |    2 +-
>  tools/testing/selftests/riscv/sse/Makefile    |   10 +
>  .../selftests/riscv/sse/module/Makefile       |   22 +
>  .../riscv/sse/module/riscv_sse_test.c         | 1154 ++++++++++++++++
>  .../selftests/riscv/sse/run_sse_test.sh       |   59 +
>  .../selftests/riscv/sse/sse_perf_ustack.c     |  564 ++++++++
>  36 files changed, 4599 insertions(+), 99 deletions(-)
>  create mode 100644 Documentation/arch/riscv/pmu-sse.rst
>  create mode 100644 arch/riscv/include/asm/sse.h
>  create mode 100644 arch/riscv/kernel/sbi_sse.c
>  create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
>  create mode 100644 drivers/firmware/riscv/Kconfig
>  create mode 100644 drivers/firmware/riscv/Makefile
>  create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
>  create mode 100644 include/linux/riscv_sbi_sse.h
>  create mode 100644 tools/testing/selftests/riscv/sse/Makefile
>  create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
>  create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
>  create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh
>  create mode 100644 tools/testing/selftests/riscv/sse/sse_perf_ustack.c
> 
> 
> base-commit: 93f51579e7df248780214094418f205253383cc5
> -- 
> 2.50.1 (Apple Git-155)
