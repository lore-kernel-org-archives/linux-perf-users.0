Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIkx7oNz"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A517E3
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 06:24:23 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so5990055b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702477462; x=1703082262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=omVCJTcadojwMs4cotPLuLe245QnocRQoPFqqhmcrRo=;
        b=gIkx7oNzAJDSQ1ualEoP+hNNiDL2eywxRkA3p+lrAYb5RmS6MTiCXCRDWI2hFeHYsz
         hYrNhsiuC3lN5da4s/jx2aFul33bcTHbupDqsy1YRbdLXrbZSUlD7aG8sX9kuDtbfvKF
         MuuFxrZots320r6Q4qy49nmRXD4PnhdvF6w4yU2S9xBf5yXq5NMmg5Nsms6MYp2wv23u
         sXA8AWP2Ef9dbrDvNKFXYm/w4GxTddFT5+Ona31ebXJBnqUmcOWJKj9vHW6R8hLdKBV+
         ST73HiAKnXsR2RaC7C9HVRxLPc1ArA6UL3DVDPTWp5UVv5KbpII0kbHvbfm6L+22kIxh
         UbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477462; x=1703082262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omVCJTcadojwMs4cotPLuLe245QnocRQoPFqqhmcrRo=;
        b=SmE1PPmhI8Phz1J6rvNJRx+ln/yhGg+PQ3ReIH5iw/bBhUVx55TXxSEW8u1fEeAAV4
         u7v79J6ooeGCZhM/cfydWBuyKPwGibDKvm8lCc6mKJuOOtJz/KsnlHAE/pOYxV+fesLB
         P4g94Bo8dB6vDqPecxZJozZ75R8kFCapEc+kZnUG2Ndg4eTXni3S07UmVZ9hjZwNi3+x
         8WiL06OBfZLZ8AZNO0m/hZue23wbWgSizkGmm1wXB+4WtYTfG2kL1C3OT/XrtxZrGdde
         GYzkEXOT2xogyCvxnUTOQeBRSiixRl2Sy2z5ihBZOn9/uIyZfTzUprzCcd99eWIAwiL4
         D3TA==
X-Gm-Message-State: AOJu0YzIvBMI1aa8No7fdB4hNC10KmVeyA5iSS22DwKs0imttEtXpuEj
	eKTuVmxhnNOljx5jXtBz+J25Gg==
X-Google-Smtp-Source: AGHT+IEokrztG2NalxBWDVh3WZZbmZHm92HATaoA6DvdnHp2D8etNOA2/Q/wsQln/1NOEu7stvbvOA==
X-Received: by 2002:aa7:8706:0:b0:6ce:2732:590 with SMTP id b6-20020aa78706000000b006ce27320590mr6836022pfo.65.1702477462485;
        Wed, 13 Dec 2023 06:24:22 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006cb6e83bf7fsm9973836pfc.192.2023.12.13.06.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:24:21 -0800 (PST)
Date: Wed, 13 Dec 2023 22:24:14 +0800
From: Leo Yan <leo.yan@linaro.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
	adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
	james.clark@arm.com, mike.leach@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
Message-ID: <20231213142414.GH86143@leoy-huanghe.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-2-kan.liang@linux.intel.com>
 <20231208102922.GB769184@leoy-huanghe.lan>
 <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>
 <20231209063440.GE2116834@leoy-yangtze.lan>
 <ee9db34a-2b3d-46b3-ba36-22a22b080d70@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9db34a-2b3d-46b3-ba36-22a22b080d70@linux.intel.com>

On Mon, Dec 11, 2023 at 02:01:37PM -0500, Liang, Kan wrote:

[...]

> > I will hold on a bit for the test until this patch set addresses the
> > concern for the breakage issues on Arm64. Please check my review in
> > other replies.
> 
> The reviews in the other replies don't look like break any current usage
> on Arm64. I think the breakage issue is what you described in this
> patch, right?

I mentioned the breakage is in the patch 04, but I think the concern
is dismissed.

> If we move the check of "arm_spe_0" to arch/arm/util/pmu.c, it seems we
> have to move the perf_mem_events_arm[] into arch/arm/util/mem-events.c
> as well. Is it OK?

No.  For fixing Arm64 building, please refer:

https://termbin.com/0dkn

> I'm not familiar with ARM and have no idea how those events are
> organized under arm64 and arm. Could you please send a fix for the
> building failure on aarch64? I will fold it into the V3.

After apply the change in above link on the top of your patch set,
it can build successfully at my side. Hope it's helpful.

Thanks,
Leo


> 
> Thanks,
> Kan
> > 
> > Thanks,
> > Leo
> > 
