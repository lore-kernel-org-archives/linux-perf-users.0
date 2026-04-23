Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E8357A20
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967119; cv=pass; b=VXmS+Vhl/3+vyKoHu6AR9A6oldLHZ0rTD8nhcfMcN1lN/1wikE2wU/mfJq2zh9LklR/k04ebTivswCjl5B9J8CUTgQukcKOOzZjWM6MAEd5Pq6q3N2+EqW1FNI5xwV5XXkj7el6MqBZ8KmMscuhVezO64d2RsMYBJMBw8GXE6eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967119; c=relaxed/simple;
	bh=Zh2fTexZLoaUL5jg9t8xbhY9Sj+/qaytYhYoAdSYlVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNpGqOv2JI84LeXrgPrSbh/zunFORbSgzriFReAuuWlPtB4WiWy7wXB5Z7g5IlAKWZry4pA57jHVPqtT2YsdJ56SOn+Y1F2aD6uBsn0rEWb7xj2USlFJEFaH9I5uBHzaB7/hzILVh/N2T6EI+/cDcGMRXPH5WZutC8jgsgwe/hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XlxA8FaP; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlxA8FaP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso148415ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 10:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776967118; cv=none;
        d=google.com; s=arc-20240605;
        b=GY0t0bUeZ1an/1uAKQ1EVSU7Nj4HX9m6GbRLuvnjBT6o2Er6nLtA1wvUdDpq8KFXgP
         sb4rycODPv/H4zdqskMLa+7p1szyvk/MVS1nEwcO3AgSWMLXBKFNMbJgH3dZehNZsQiz
         jaqLDfUMd/GzElqe9kJqqhPvx6HxOg2JRJu02lijge1Nicwvzf4Vb5Sor+ciVte94PM7
         KBjkVzjR8dvQe2AMLjWQwUpr+sBV6eHK2u20b+tZp9Vc9+dVM4mQF7D4ekEK1NEgQeBo
         6AXW9BTFcOkWU1pWbX1k1XZkZVii5q4p78mxzgW+/IrCyYviDp59oPd1hutZdsdIYJ+P
         KnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zh2fTexZLoaUL5jg9t8xbhY9Sj+/qaytYhYoAdSYlVk=;
        fh=q0lozDfEsnr5dbxj9rYwynzpj4k5pP4dtjx6fWYNQRs=;
        b=hFbC66zjHwiffByOj4oyfvqkxznoRV7xFx9447yiJl7BnxRkBvxIe2BeBbLwrbCc5+
         v7LQ/yBt7P4cYUk2FgpI89xhUvfa31kLHMfYFXGeVipERxuT6RMwpdokyt8+79Oi6d0e
         t0YAVcTnrja1zpjNL/yqEOvjEkhCG76sTD5fIracPhDNTaNn1TN1VsI4h5HS+AroIubA
         PQsm6aHQmkM71/catp3W6Oor4pOH+VMmpXjn+kfOdQfpCt+LxxtBV+HnwYLx7A0c6mkw
         +h0/va1wtPsnkd57hJixPH7RJdMyaGPP9JlVPZApOpJRXMZn63NpOBO2PtsIIUHAo+gw
         lV3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776967118; x=1777571918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh2fTexZLoaUL5jg9t8xbhY9Sj+/qaytYhYoAdSYlVk=;
        b=XlxA8FaP9VyCQgtFW1w58UuaPpmiIvf28JC24Ust7YAuGaAB5PRET6PFF93YuyCOLG
         3yAWXploFMHBfEtBgBY0cQynTT5pPqLO4n7TbRxZpc7fk/LnupH4m098kxgU2BJOW4yx
         jHiaLyGyJLp+dxt4wQTuRybfncK1mpF0o0NTwYyphu5oIgS7AEW4PGseNOEqnKDrjuVc
         8MC4Ka+jTLI0rfsqlS3BsmMzcjRyhF8+upwugHz5Ia545n8A4uqkAJo0vKPn9thESn29
         ESIooU00q4Rl+gu8R8M7BJhVSIL6y1u/dURIYU+Os91zrRztVQbv3rcdzRz8CjUM34Y6
         e6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967118; x=1777571918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zh2fTexZLoaUL5jg9t8xbhY9Sj+/qaytYhYoAdSYlVk=;
        b=nTJVM+vMWxcyjmwx/x4zuNBa++z1GqapPdZcWgl8/64pGWp+7HbWAtJ1lTWASZ6idy
         V8tbz8GDLf7xReqEIUvqu4ZApJoP3RGNHeguBoZRWH2++VIoFQ8cvZWwL5qAeRL1RskC
         e0TVGkjBVWtFaMr7ivqu31ICMDIENMzk+1PK9mmwONPIE7qDMNtX9mkUIIpKh++FjvW6
         AkQcXKDLJI4fcwnuAhAZFNkrCUechb+arlBsm+hnwcGVFCoRPiU1MDM+G3wA+SB985c8
         JEdbB0m4MryT3vhzPrpFqgeC6yXtQaecc5Cn//4O1Z1J2+sUmS2Qb+BaLhQyhZUr1qoZ
         +6JA==
X-Forwarded-Encrypted: i=1; AFNElJ/IHyaJovxP+zZUSeL28tHmRLbXFeKsdAZtxh0ej1gzHp0tnu+8pM5hFuKp9ifrYKCTqbce5BeGNsq5ZInCdxrn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iozkanIdBAg96cnAMhp2ZK4CCDVtxD6kJ8DPloSuE33tT6ij
	dPEwfYmbXMu/w+RBAX9Ot4pYNx9dL/RjaBa7NUguHys4X8RMYiNwCdQmZqBToBivFJjSltf6hCR
	2Ssxfndtx+DQOqTgtyLmJ1cm4gt0oO16Bg2DmA/ep
X-Gm-Gg: AeBDiescU9QaJAeqSkpKOKf5F1yqJQeoFHhwOL84K9be23N+nhwSmxlE8K3BpYo4Ebr
	HqMmnrqhq6rpNCyzhT8qmGdtFi7RZSjkdyte9H/Vjr3X4BCdvPyVhhDsLXnE+HddV2DZU83Ziyr
	K61kxWvzuYuqgySVopo/6PU1pjioKlAI+oHr7g5ALI8iosO4YXSUAuQzJ4nyWUz8FQOyOGZwdDT
	hsBb7X0Pktbhmyrt+ZcczoYczQYjtZZ3QSOP8eNVer1r9OAjnzr+2xfWSK6yMcDX8OUqC/Mawy0
	i5zH+pTe6RyDG4pcQw7kH22YME3m9HSnj1i9ocV1jAKkb6Mnv9e/WLAFpA==
X-Received: by 2002:a17:902:f08d:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2b60307dd17mr13087645ad.20.1776967117663; Thu, 23 Apr 2026
 10:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Apr 2026 10:58:25 -0700
X-Gm-Features: AQROBzDZOqFUFwB-H8xIRjSSXeTSAo0kwrj8qwOK2TOrY0Gr0X96Io9-RhPhqf8
Message-ID: <CAP-5=fWnKdzUVeAxAgoWp93HozUQ=mM-G8SKD7ZmVQnPe063HA@mail.gmail.com>
Subject: Re: [PATCH v4 00/58] perf: Reorganize scripting support
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 9:34=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
> ---
> v4 Changes
> ----------
>
> Sorry for the churn resending v3 plus one fix!

Sorry I hit a quota limit so I'll wait to send the remaining patches.

Thanks,
Ian
