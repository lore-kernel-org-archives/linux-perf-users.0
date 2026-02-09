Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06D2F3C26
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770607202; cv=pass; b=nsvtcAtHZYf85uXarJpfHnfOd50dvBG6TqKt2TSTIZ1h3/eXA4hm+2oHbIWivKgteYMZ+1QQvewOxTTGQoyP8Dzx/fZhhcncKsI7USxdvBifcyNhQ6fAvRYApk15ZgqC11w44gLErQpwNP3ri46xKmq4Rr5V2xv2rEIwymMuudc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770607202; c=relaxed/simple;
	bh=Smwhyg4YBNedQzdY5sUMXwnEeUZt/97AQz5HDdbDHNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRx/yph+yVHxnmy507PMN2Wdo9y1fteYSrq+vdZHuyuM60qB09ZLF3DcD3NR8wOlM37YyG86qiI2kq8KHDNlf5dKhVPMdJnv5UyPFU2ZxCVh6cTb0FzHXfNEeJVQBbP4f1w5WtcPTNfp7YHNROFsGzhgZFHIBH3qflDE29Q/uVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QCQPmuGF; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QCQPmuGF"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b886fc047d5so712044466b.3
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 19:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770607200; cv=none;
        d=google.com; s=arc-20240605;
        b=F5V65UWXqzZZKBVnMOqyV422ZFqM6+FUGnS+Xi1dBG8Rln9Rsk9nALqzdWYB61MN6E
         TO190DSFao+MmP3ESgo98gwDjIdePskyT5kRISKwIXJseoXiRp9ji2mkbaptRraMmeW+
         QjMJH2JsnAZzaQVG9rI4x7D/5Gs0X67b/l09cqq+tNZr2ROHRcaWN7dJ8vPebDQQeuJO
         WldhbZ2bF7Ye8PDpD+SHrzaZznc8EBnjMa74EDIOSm3o1aCOs3yshnDGLnyJK2PunQ+9
         XaGmkHFv3Dk/q7g8uHtEvYgtDcB1Us36WocnHHr8QjEkSOo5GzhytRMI7WHQ/3E5C+TB
         HPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QTpZ3dQhsPCIcIyPizxNOmCsub1MA47o2XGIfp+wVqw=;
        fh=PpHoUaA9o8iahQI1AEGxh7EctC58HTSowK6R2iK5vVQ=;
        b=ZVKOVaNcqhd6gyu3OLd74f2JCxiXjobbvFEE6S8WCragOzFF+gmEhXe1B2NcPz3ZiY
         cbYXpEh40+OzYC/FWn+5XVuy3+a8G2yvUH2AHMjJ7uY481PpwY9xkMp1zg2pOr6GMLH8
         OAjP76QLELRZjTD9yBZVRid05mP8kVkFp87EpvQ2VklCftaD69gM9P1pylnXGBIfVtzI
         zVD5y+MpahwUc1CZYVrabIT9twuA4Wg6+q7QfFAxAKCt5c/WZB+k1OSSpTBHrsKbJwfK
         nokDVkULiV6zf6afij5ZSHcLO3XN278dhfgsjFxn1uV9asUsgyyPCcv6auJH/6vgAd6g
         FuXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770607200; x=1771212000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTpZ3dQhsPCIcIyPizxNOmCsub1MA47o2XGIfp+wVqw=;
        b=QCQPmuGFdcRZ9DgrNPcFKWe7yHcBx0hI7xIo3W470Oc/JF5vOfVOiyjdgsPATecEal
         O5E8rdn5bcHKmvefaI60CvadjPtjwKhRTMeRpJrug2HJbRoaTxZqyizDha00RPbgFPIm
         WegQ45HEmlECKTwPZ4hDA3ic6oXjllheV89Z7uYjyqd3YS3LdNtAox4oR0gI9H/ZpbA0
         GPODUz9KyPk445wTqiPXE9JYo9zDZDMk3iuKOxaeiGIxf5KV0NplIIDl/u6Q4iaORj+c
         Cil3tREDyK0hmqf3j+3XU+rJAb2tBpiFhemOgxTho/ZPVcv86vk7C8gEzAFPva8ee99G
         r0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770607200; x=1771212000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTpZ3dQhsPCIcIyPizxNOmCsub1MA47o2XGIfp+wVqw=;
        b=VZ9SvAWESYOcAOAJ7wA2c5Sg+tQBTSZBn8ponYsGEr9PwhXGq26BFW6rAU9rBuiX8O
         hp4vpq1lRQRK+5T6aax5YFpeMt70RRgVahcDAQmx1r1fBWRj8YYnvCyL9tnOdUCv2yiz
         OFtOnkNrzN/Ji4WyHex7+o6MtSlzL/vV42dHLCfGf5628UbyMWpRyXZ49lt2QFzLlqo4
         LypA05dED04t0NImGUjy6iBf/+AL37xx1GcZAwEtIgbxmDiTPVguuwrphsLIQRAvErLU
         z9iUmW/NmbQ6SsESLrJQjRjE/F3phutJSnlqNi4xm3acoD/bQt07pAdOfcMec+TfHTii
         abMw==
X-Forwarded-Encrypted: i=1; AJvYcCUEysIJt646CvhEq5BN75wQ2dSeOJ1CMmRStHt/RHs+zPiIuyr5/HFqzQ9Qr8yckeZ51+g/jqH2dzJN533/aORo@vger.kernel.org
X-Gm-Message-State: AOJu0YzPeCUresm+W8mde77d0ghawKrP944EsEEHgEu9qTn0zOS2IW7j
	LO7EHXGDv+Bst6EH2s9Mqr+zm12hJwC4gnCNMr6dyREQrUaaMbC2eL7I1sdxvPGtcut7iCvOp7b
	LXxxjSBMm5k6IegLdd3rVd1Z5JiFXdga9sDYFErqVEw==
X-Gm-Gg: AZuq6aJ/lVieq5ke2o/8DUUwcKJFHwLhmHYmkucOddw47MxfQ5807Z8HlXMUhOKZMIi
	quAHtknckWkUCjN3dwrP91ZFE0IrirwAQx2g0QnA2xDfzOnP/Jyyq/gpWtGkwtcGhRpfZiu/hdn
	evJBmFp6f+Uz/uIspnfdh/Wr+3jy7ELO5tnyFMXlZmkfjJrEcT+6wqdobcNBxrOSEnTChtwbtTs
	ABRkhPyqK++LidKffFJcv+6BaPCqsosX8fIi5ktmmq+gLXbVT9baZHVm58xjRRzDzMgcSd8zA==
X-Received: by 2002:a17:906:d542:b0:b8e:d04e:e4fb with SMTP id
 a640c23a62f3a-b8edf376150mr579729666b.48.1770607199749; Sun, 08 Feb 2026
 19:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208063848.3547817-1-zong.li@sifive.com> <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
In-Reply-To: <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 9 Feb 2026 11:19:48 +0800
X-Gm-Features: AZwV_Qj-9dR3BKTCPrhQdA6_UiWDK2OsF9j8utjRQbwYmgBnYFrxlf2qIsKG7xM
Message-ID: <CANXhq0qmc+vo6uX3ySqqQOPTHxKHJB8t1XC6JuxWs3K5_qoTRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V IOMMU HPM support
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	conor+dt@kernel.org, guoyaxing@bosc.ac.cn, luxu.kernel@bytedance.com, 
	andrew.jones@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, Jingyu Li <joey.li@spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 9:41=E2=80=AFAM Lv Zheng <lv.zheng@linux.spacemit.co=
m> wrote:
>
> On 2/8/2026 2:38 PM, Zong Li wrote:
> > This series implements support for the RISC-V IOMMU hardware performanc=
e
> > monitor.
> >
> > The RISC-V IOMMU PMU driver is implemented as an auxiliary device drive=
r
> > created by the parent RISC-V IOMMU driver. The child driver can obtain
> > resources and information from the parent device, such as the MMIO base
> > address and IRQ number.
> >
> > Custom event support is not included in this series and will be submitt=
ed
> > as a separate series. The idea is that custom events will be defined
> > through the driver data of the auxiliary driver. When the parent IOMMU
> > driver creates the auxiliary device, it should pass a vendor-specific
> > name as the device name in order to match the corresponding auxiliary
> > device ID.
> >
> > After my initial RFC and the v1 patch series were posted, similar patch
> > series also appeared on the mailing list.
> >
> > One was from Yaxing Guo:
> > https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
> >
> > and another from Lv Zheng:
> > https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631-ac=
1c352a469f@linux.spacemit.com/
>
> Please do not forget to Cc:
> Jingyu Li <joey.li@spacemit.com>
> I only provided T100 specific support in the posted series, and the
> new approach of the HPM driver in the same series is composed by her.

Sorry for missing Jingyu. I have looped her in this thread.

>
> >
> > Yaxing has agreed to pause his series, as discussed here:
> > https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc17=
1@bosc.ac.cn/
> >
> > The motivation for sending this v2 version is not only to address the
> > feedback and suggestions from the previous round, but also to introduce
> > a major structural change: the PMU driver has been moved under
> > drivers/perf/, which has been mentioned repeatedly by several people.
> > This results in a different driver structure compared to my earlier
> > version and the other two series, and I'd like to gather feedback and
> > suggestions from the community on this approach. If the community would
> > prefer to go with Lv Zheng=E2=80=99s version instead, I am perfectly fi=
ne with
> > that as well.
>
> We'd like to know if there's any comments related to putting IOMMU HPM
> driver into drivers/perf folder and want to know if this is necessary.
> We also hesitated if riscv iommu hpm should be put into drivers/perf,
> and according to the followings, we finally decided to keep it in
> drivers/iommu:
> 1. drivers/iommu has already a folder maintaining all IOMMU stuffs.
> 2. drivers/iommu has already defined HPM related registers.
> 3. Unlike PMCG of SMMU which is located in a separate namespace, RISC-V
>     IOMMU only defines 5 registers in the same address space as its
>     translation schemes.
> 4. For HPM schemes that is not a standalone device, Intel has put its
>     perf driver under drivers/iommu/intel/perfmon.c.
>

As you mentioned, it=E2=80=99s not strictly required to place the PMU drive=
r
under the drivers/perf/ directory. I think it would also be ok for us
to place the PMU auxiliary driver under drivers/iommu/.

The key point here is to make the IOMMU PMU driver an auxiliary device
driver. Our intention is for the IOMMU PMU driver to behave more like
an independent platform driver, where vendor-specific or
hardware-specific information can be provided through driver data.
Custom events are one example of this. Similarly, if future versions
of the RISC-V IOMMU introduce new hardware features that need to be
distinguished by the driver, we should be able to handle them through
these existing interfaces.

Overall, you might consider this approach as using an auxiliary driver
to prepare for vendor-specific functionality and to allow more
flexibility going forward. If you also agree that this is a reasonable
approach, it seems to me that it might be good for you to add your
T100 support on top of the mechanism provided by this series, and then
append your patch after it.

> Cheers,
> Lv
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
