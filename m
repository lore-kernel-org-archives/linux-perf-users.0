Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB951361945
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890444; cv=none; b=kA4W0E3ubSwWVZ3RdPWbPkxZm6cs+XwJ2YQhu0C2Urf8dSaQ2zRzYAjlkn38rTalHKbV7yhoj7NceMbsxCwa4lUkwSbr0CY4z2rky7nUakTtxew3JrRaMMXT5m6mwGVx0cefgbMLeOhYts7i/MTMGaTSimtgr/U6tknqZPM3QkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890444; c=relaxed/simple;
	bh=nT9hMrtZRR/2siI80QtehZ8BnMD1l4DAL83J/BAbUcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bhaDgSA4h/B2E3o0rJIDUgtd+/Y8kwXYKXmobuKI0lBswAxgrPZ4+id2Rno6XLRVVVKA5QL6E5WDOM4JUfTCb4+5eYuHlLh1BnoZxgPxau6/QYzDmpqb8yHHikfcW2w6TpgGHIdsSa/zcqz7N7P5onoubRzvPTlVduYkO2b02DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlM3Lxtc; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlM3Lxtc"
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4e937c5bd4fso4868111b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790890439; x=1791495239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nT9hMrtZRR/2siI80QtehZ8BnMD1l4DAL83J/BAbUcM=;
        b=tlM3Lxtc3WbIZgWz/Xm+xUadbSBplTug2uUjQgOHf8LqtVeSfHnfzdKEY3MKHG3hIB
         pGbXeenqxFZMyOIOw5fLqnl4Vc8TXJx+iLR2zhaY3T74vpojbMBPtA+AxIqDsgZeTi1X
         NHyiSKlysIlTdFyhK8gXAEcGZTg7EPVyQVoYO563WrhvWt1chumYtIMU4q3h5188AFOn
         8bRz11fSTBgxH7CrBAdROTRTlyIKahNT2RP+bZO6PiBfoY4EVVqI+KrSDNp7Rcfkn70l
         sdS4UhbqD28R022nca9PFW3THNTgpMqV8e0fnQrSnc+2YHt5drIXwrer7xEAJnUNz/1i
         DWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890439; x=1791495239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nT9hMrtZRR/2siI80QtehZ8BnMD1l4DAL83J/BAbUcM=;
        b=acgpyWhR3QXMNrpuvZRr7h3n+T7oQtCSRgCOz29mJ+58qu0ZObX8urU2Q4JaFEUT18
         I95I5mpVNBYuAPANpYtouBH5qJbhMX1S2pIf1rbAReq7WmQGewQNnvGnktaaGCFuWjM/
         zHOOeqVTG1PbSqY3XPFh8xy3ljq6Cbk74O58Ki8pJQYB1hCx0koIWDFFoam3H70a1ObC
         aXRiEFpzJq0EylhRYsElMm9gIH+31c2B0OJUg2F+mmTG4fp0ke+Mwq09QxV2bKNDU6IF
         Uncln+cTOceQWaAUsAZ7vNjnHp3DJfWQFSbsl9XH8pPMpFp+4kg+9FQRRrXr2QsouwQU
         fbVA==
X-Forwarded-Encrypted: i=1; AKwUvBwc81JOxUPCb8dMEOh+ScU5jmEJhdkeNt+2Dxl4veTnIcxKbQl+0e7A5bRmnploQHWRCVVA2/KbRcThG2Q+g1Of@vger.kernel.org
X-Gm-Message-State: AFuF++nhbwCj1rDH3CURbQjI0X28Ebs+cRB4Bk/D7tV7Cq+xhK0T8skZ
	kSV7qA1OtvbWdB7LgHD4ru/7JfwFhZCpXhM5GZgmfkfR2n7X9im/q6Dh1NqdEAN6ldtHHYTxCVQ
	PQiNJQoDrQrj1RA9KfAbEUtTfWA==
X-Received: from ioben34.prod.google.com ([2002:a05:6602:3f62:b0:9af:289c:476c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:bc1:b0:4c3:2e7:55bb with SMTP id 5614622812f47-4f52a57e776mr435364b6e.38.1790890438606;
 Thu, 01 Oct 2026 14:33:58 -0700 (PDT)
Date: Thu,  1 Oct 2026 21:33:56 +0000
In-Reply-To: <5750151d-cb99-4f9d-b469-12a7b7796985@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com> <5750151d-cb99-4f9d-b469-12a7b7796985@linaro.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001213357.2088894-2-coltonlewis@google.com>
Subject: Re: [PATCH v9 00/22] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: James Clark <james.clark@linaro.org>
Cc: Colton Lewis <coltonlewis@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Zide Chen <zide.chen@intel.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Wed, Sep 30, 2026 at 04:26:23PM +0100, James Clark wrote:
> On 24/09/2026 18:29, Colton Lewis wrote:
> > This series creates a new PMU scheme on ARM, a partitioned PMU that
> > allows reserving a subset of counters for more direct guest access,
> > significantly reducing overhead. More details, including performance
> > benchmarks, can be read in the v1 cover letter linked below.
> >
> > There is no longer a kernel command line parameter
> > (`arm_pmuv3.reserved_host_counters`); PMU partitioning is now completely
> > controlled via the KVM API using `KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION`
> > and `KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS` vCPU device attributes. When
>
> As far as I know there isn't a straightforward way to get the number of hw
> counters from userspace. You have to either parse dmesg or attempt to open
> incrementally more counters in a group until it fails.
>
> This makes doing things like "use all counters for guest" or "reserve two
> for the host" difficult. Maybe it's time to add a file to the PMU that
> userspace can use query this.

Inside a VMM, userspace can query the default PMCR_EL0.N via
KVM_GET_ONE_REG(SYS_PMCR_EL0) after KVM_ARM_VCPU_INIT (or
KVM_ARM_VCPU_PMU_V3_SET_PMU) and before calling
KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS, since KVM initializes
nr_pmu_counters to the PMU's max_counters (which is how
vpmu_counter_access discovers the limit).

For users and management tools outside the VMM (e.g. choosing N to pass
on the QEMU command line), I agree it's awkward that
/sys/bus/event_source/devices/<pmu>/caps/ exposes slots and bus_width
but not the number of counters. I will add a patch to expose a caps
attribute for the number of counters in drivers/perf/arm_pmuv3.c.

Thanks,
Colton
