Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCC1F4C83;
	Fri, 28 Feb 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764453; cv=none; b=tNBJVGptLzv1ww/tAAjN2wDna9upgz1P7S2FeOT1EYnKDqkA2NA8Gwksvxf9pzvAkzVgn/20C9TtO8lKSLwN/5j50bON69wbwqjmi844GELWg15V4t6mocBk5mbItXrbpVhKrhQqLmn7gL/lgUZGpjsnrxhOzhErFXrET7tBwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764453; c=relaxed/simple;
	bh=/xteggQ4c0DV4L7SQTkKZ+j2wkJckOWoOGiJgXVIoCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSZtZn2AA1AYhNFE+BtKFU4m52l7r0pDKZJEtEZea1pHvbSp5Vh0MERpSatDUI8c/glBgJ7bBdmVvStaKZBFppvd5H6jHc9YGOZOXXsqulxEeDoKStT3zRBpCRtxDOC9dRUMTH88DfZyu4tOLm41S+pG0VFgKIl6RmqLpmQNdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi6Uu3/1; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi6Uu3/1"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6087a8588bso2308472276.1;
        Fri, 28 Feb 2025 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740764451; x=1741369251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xteggQ4c0DV4L7SQTkKZ+j2wkJckOWoOGiJgXVIoCM=;
        b=Hi6Uu3/1fV2uUtFMwQH4o4IG9DuHM5QrsBD3msKmfxuXYL+ArKb2UHf7bvKhFsG4P8
         LoahbjdODs70xvzoaDlQykNgeXRe+ztiZYyz8N3eZmh4KLy3sdlPxlEK4upukZ4oj1QU
         LanFNN/IHm4DEdegSwbSZvnwl0+Yf+zrE2lp4mWXPLgjSWj23cA7WLkWfwaMhLku9Ve8
         YNDWZNJipNemlrg9JV+K/wNedysGrAZAd5bfRx3f4DeI3C2z6eN6cr+8xVT8kAGBFy53
         r6TtfAE5w6hv2sVzfz7l/cvm4ScEfXG0N6wg6Rtw00ZVs073tVNvP/XqEGmxUTKwfyqV
         9IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740764451; x=1741369251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xteggQ4c0DV4L7SQTkKZ+j2wkJckOWoOGiJgXVIoCM=;
        b=JE2l29dwdmhs1ozIqE3hHpeCk14ng8zmqDkIrn/A2vSJFtOaXkLPrlQIul/7yQBWPi
         SDJV+wZS7HBOkOWUTevX4wK8uhYcq5DVQ3wQ6b/lEaqF1b6ljUvSloTPBZBKgaex2wuV
         1VQ+nIL/nAtUTigAuh5Pg3oOaSAVOzVP38RyPZo7tROVpWIm34FqGhXEN8Y8ZkM3uA8Y
         8zMaI0O+8I+m7kaPTJxCAVWlN+bwo1hhLXDlfLKOgvKbD9rd+F1ajQ0kudk1RZ19MTS9
         PwVMoJlJNHqZRfgIpcT+weiteKHloJA8R7XdnJEyMCJWvJFf+/87WmbXI7J5XcjbYFnc
         g3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVweP2TnWE9nwdG/d5H49s3/YgAcL/RLjovnW8L/GxwQEF6AsQ6g3qiDtpB3CGk5WK54V4ZTuk2kwOW5XI=@vger.kernel.org, AJvYcCVxi2l1itUuX0DS8PuDkduHb0CBak8pvXk0Yr5J1TtHRDgS8mRFoWBMaJVW6IeESB6rN/wg8FY+z+kmWTThc0jQ1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDjVmgvnGRBMUqvTy1Y1mgGiw1v8C44v+SSVrwbETz20OWIXr
	mlNQxFsK+0XO/6sLFOmjP0JCJJz+ZNWaR4GFcgkRf5vvOnAsR/fVYV92goVLTqsqFwDeaN95B87
	hYN2TW6FwRMBzg0yd5moZ3BDPOAZ2J1ekPpg=
X-Gm-Gg: ASbGnctc/Xm07/ueolLUpWZdjEJNj/PZRquPtoAlQzcDeiybyAa3MMvwyUyOF0cLq0X
	KU3QBI2HwTKpJRIQR05Ttpigg3y1Idz+oFR6K+EYT0/FUptog77PmKxuHNlSJLSnf9FgH/aleLc
	/P8ozZlw==
X-Google-Smtp-Source: AGHT+IHMi+ZMKzEkN5DWcxsa2qvHX0d/6WxMOVrtadkdAVIN309S/jzHhDy85lH/eF0FYfhHwAl+DnjlRolP2ZfEjkM=
X-Received: by 2002:a05:6902:984:b0:e60:b135:4c07 with SMTP id
 3f1490d57ef6-e60b23f8863mr5549512276.15.1740764450922; Fri, 28 Feb 2025
 09:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213230009.1450907-1-howardchu95@gmail.com> <qzkn72zddcdvwst2a4jfeyd3lalfvaydvisx24egxjllvlf2ym@qc5ozzzeqhd4>
In-Reply-To: <qzkn72zddcdvwst2a4jfeyd3lalfvaydvisx24egxjllvlf2ym@qc5ozzzeqhd4>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 28 Feb 2025 09:40:42 -0800
X-Gm-Features: AQ5f1JoYKiM6jmQOr8lTUgcL2TrSePojmnODpz7nywXcd5ibB_AWuEzeKVn2_lk
Message-ID: <CAH0uvohnik1UqGkQ1sB4t1-s=uOAaauszU4JyjLjJai+6rQ8mw@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Gautam,

On Fri, Feb 28, 2025 at 8:37=E2=80=AFAM Gautam Menghani <gautam@linux.ibm.c=
om> wrote:
>
> Tested this series on IBM Power machines (both pseries and PowerNV)
>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks for testing this series. :)

Thanks,
Howard

>
> Thanks,
> Gautam
