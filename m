Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C015A840
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944520; cv=none; b=WGxPVisfXQl21du6GTqhOnAT81bxZ28XBe12pChcx/QDeP1HkAAc/nfby6RBe+W4Szwl0+9G77Q+F12PH6ly5Au22d2UbJqImDvdImT81UO60nxdgjkraDYhlWacKYlsfEhkIF4mX9ubZ4uaovpN1VxRaWQlXocOueAHYGQB2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944520; c=relaxed/simple;
	bh=Gy/amBuYClm9VAhnL0QgHB7T8TViYJoXaPNqF3ir5/A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dz6+WH4RfKWtfVCJkD82s82N02Zts+e4DeeJjR2tDA4NRfB9JYzxhI9oMk4h5+3qpkESD8Tz4b6u+RUYriHvZH6zFjAkn5e0TTPo6mnF1UWNIZVOwavOsXn5tDCxpM7FAUOOIbqf9VE9v60GitRDcDbJR9t1VFG+HqmRhIvd69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FW+rm/Me; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FW+rm/Me"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43e14f0bd75so94431cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 18:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716944518; x=1717549318; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy/amBuYClm9VAhnL0QgHB7T8TViYJoXaPNqF3ir5/A=;
        b=FW+rm/Me9OcGbvHHT9EaiO0NmSUQnRXnAvfz69JCFVfU8gxJSCxcAQ+SsC5MwGxTac
         l4l2a2bpyzfPDtZxZiztjkiuzPu/5X6c6Xk8hxe/HW32NYyxWdKhw6dA9/vtLciWIovS
         ubEuJHQaFyIqvO6OZU1+KVjTQsrn5iSyqkoEjRGjNa/qJz7XKX+IIjgpHAbN43Hakx/Q
         1mOTebciwwfJwgbIXo2LrF/XGMFz4Lmdo4uDHV9Yj57vj4wXPhOj/+jtIUEaPU8WdAzv
         9ppbIhGWt8B8Hkq1faO1tK01RFJBNkXbBfTZPAAHskkPbzEHKWJAVdE3gOWdRr1Ly2kp
         OwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716944518; x=1717549318;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gy/amBuYClm9VAhnL0QgHB7T8TViYJoXaPNqF3ir5/A=;
        b=ZOqKW2hc2Js84bFGFy24HPxesodmkZBCTqxUVqnGmLuFAxeG3Pp1JZcRobchwcLXss
         bwnaJ3GvA2hgfizfIG+wb6tFNhrLCatmsJbxwqDcAqjE9bgWHhjymvgGm6/xtVnZeiDY
         27OC2g467O6yj1pBdtZjY26pyFJdADUjd4xpAUeFwfykxrgg1ZBsZUx+u+lY9bTfeOSJ
         i95kTsrm9IVA0+evGuiR33t7jHkzcJCp4bx/+toruSdG1+cAOmefvpcx1IMx3aOkSZ3d
         MxF6cGM3T9E250x+QJ+rRCa5f60GIN4GhqNOxA26lJbVG9otT3s+RB/BnkWBTUO8XrQW
         eu3Q==
X-Gm-Message-State: AOJu0YyPaZK2I48Fgq1MJtmYN8UXH9m/ec8bXrGAfqkT3DsYEVCKKdGZ
	bGS0Ibz5M7lZ7AVUp6cLqDLMtvI9j3kTX/GiuJ7SmGem1QZkLZLgErXusga3GD65jL0jA7Lq+oC
	FuxkQKBpUTomPEDq55lc+NwD4LjN0/7hwpwbHh0cvMGkfRqVHexiveJw=
X-Google-Smtp-Source: AGHT+IFAsFwpokoii7CwqeSoDEl7Qa/VvNij8QCnCczlnK+W7oAwrZGmOa7MmANXItpG/dLcB//T3zFXutVYLsqEXDk=
X-Received: by 2002:a05:622a:6119:b0:43a:cc48:344f with SMTP id
 d75a77b69052e-43fe290bba1mr434191cf.25.1716944517900; Tue, 28 May 2024
 18:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 18:01:45 -0700
Message-ID: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
Subject: Linux Perf Tool Office Hours
To: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Monday was the first day of the Google Summer-of-Code and so the
community has a chance to sync with our contributor Howard Chu we're
restarting the weekly office hours. This is a chance for everyone to
speak about Google Summer-of-Code and any other issues they may have.
The meeting is Google meet and the details are below:

Linux perf tool office hours
Wednesday, May 29 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

The timezone and software were chosen for convenience, if people would
like things done a different way then please speak up. If the meeting
software doesn't work for you then please email or google chat me and
I'll try to add you. Fingers crossed it works, it has in the past.

Thanks,
Ian
