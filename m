Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F2A1366
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jan 2024 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705724840; cv=none; b=lZicdl3L+qEm2V6yo75PGd1NrRVtrfMLxmf9Qcumwh/ATWtHCamfwFIatz22fO1qC7PdgF5hdnSQDHVwabXNw+doVNPNDcH8O8fpUo6PbL0w8blrDc8oITry3Fq2wJtTb0lKcC2q10lYRWHkS18fGsrFHGZlZ3kRN0LZ1TX+bNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705724840; c=relaxed/simple;
	bh=2SAuD8JULtqFOHFOwXaVvhndk/zoEAaUcvyKvU3Pl/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocVhpO39CBRK5pQS7XBy7OhNKSLBkK8rAjUVuca1aWnxc0hEp0dzfkhnFvdCBeY+/eyket3FSxWU5pi0iZ0P8zdrdIGNe6TZaHM3vHOm96cR+DeJpEVz0rVz4EN+JfQ1ZOWd91gW1LTWRXmXe5gtsarNJ9l1Ea6WQdtzcE/uN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8shnOB1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8shnOB1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d72d240c69so36975ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 20:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705724838; x=1706329638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qp7VNwyMsPizsxrBmihGBgOpfuswepo+cfaUnZUFOE=;
        b=I8shnOB1AYNnBMXkJTCe/w7C/Hy125qShQIZJHlYOfi+KD7egcAwRvKR15duowNQWd
         1emtJl0cb7IvR34Bu3iRxr0PA3lIt3AysBfkyEcUnGlTMPyt+RmapROWZfcKOl8m5zIa
         uMYBLDoPdZ9WkuJ90xpDSoeXgfqFLzQIDmSwtyRlONR6ID+8eJAgmk++AE9pOH77Y6sc
         EPyxmwoAT6Qxjyyu01A503u0cCb1jahPSB3IHAqoZUHAzEKcwikXSGr39FWEcYFTOg/U
         nDjpeBMNn39W59QWXx0+ml3D3YQPb8qPQ0VNLFP9ANHGanYUwFp/d9Lhctahou2zv5ep
         6soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705724838; x=1706329638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qp7VNwyMsPizsxrBmihGBgOpfuswepo+cfaUnZUFOE=;
        b=ho6OuoAYGIAXgHcRZQuSpYLcjdE1XLRp5ID/qAYk2T1HsC01itGohcLzHYrD+Qc1Tu
         BJwnxb7qBtekkvniUfxQILATa9HE7eGhLljveqdxywp4bwGecqdWO9bKYzBpM970T0AD
         S6M3ZQ3qndMmzmzl10HmUlxCi/XByr82y9FasE5+Dp5bsaIWFUvB1mCbOG/R2zzS/b/u
         hKhzy6xvLuIawLr9KEW3Z4kZWMyzCRKFwkui4Mj7FsbE+zhjSZdD+mqj3WTSj7tqBPWS
         qqqsMqlWOmwHLMc+SQJS5VsYukpiH3SsbQhJQXe01BZtDf4DhVeBrsz3l2WUBhF56+jN
         c1kA==
X-Gm-Message-State: AOJu0Yw18kq01rO49OP4KhnAqeWWssGUmogkE6tRggzw/NpeT/2Ddu04
	OS+cuRZyNg5xvf+uYNh5s3tk9hdFosRlWuOvMoxrKtSqFgqlkOmHKC8JSPrTyRepxfE=
X-Google-Smtp-Source: AGHT+IGqrGhVN9rfHEG5r8dkvwz8WMQpQ/t6dldm4vx5O+cHNXSUxQCmhALyg9RPCDLvq/U79YXApH524c2ATRJR/N0=
X-Received: by 2002:a17:903:2806:b0:1d7:70f:c2b4 with SMTP id
 kp6-20020a170903280600b001d7070fc2b4mr13366plb.23.1705724838371; Fri, 19 Jan
 2024 20:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
 <CAM9d7cjgu=Ec0Hd83sn=LkHrHBGciCev=tE1vRKFMhzNo4xipg@mail.gmail.com>
In-Reply-To: <CAM9d7cjgu=Ec0Hd83sn=LkHrHBGciCev=tE1vRKFMhzNo4xipg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jan 2024 20:27:04 -0800
Message-ID: <CAP-5=fUA39pwG+RaL5ZN3gFzemvTEAnw8EgQAeHGGGBAOqNu6w@mail.gmail.com>
Subject: Re: Issues with Linux perf tool on Raspberry Pi 5
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 4:55=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> w=
rote:
>
> Hi Ian,
>
> On Fri, Jan 19, 2024 at 3:40=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Hi,
> >
> > I thought I'd report the state of Linux perf tests on Raspberry Pi 5
> > and so I opened a bug because of the number of failures. I'm happy for
> > help resolving the issues. The bug is:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218401
>
> Thanks for doing this.  I've looked at the error log and found
> it had a failure in loading BTF.  Maybe the system setup is
> more or less broken..?

I think so. Looks like the kernel was built with CONFIG_DEBUG_INFO_BTF disa=
bled:
https://forums.raspberrypi.com/viewtopic.php?t=3D349411
They also package libbpf-tools and those tools fail in the same way.

I think the fix is to update the bcm2712_defconfig:
https://www.raspberrypi.com/documentation/computers/linux_kernel.html
https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm64/configs/bcm2=
712_defconfig

It is kind of a shame this option is opt-in rather than opt-out. I
wonder if there is something we should do to diagnose and help users
who may have a BTF disabled kernel.

Thanks,
Ian
