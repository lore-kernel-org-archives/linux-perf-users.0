Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF1659
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jan 2024 00:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712158; cv=none; b=SMZV1L7ofzuz1g5QshjNFTYmGe4G0C7W/iDgBywioASIb3Wb56nCH8JTBow93ZE0CoeHkEniuz8fGvBz/fJCpvQc27aRlbOKJKC/Zqkph8M419POyWmAoreFDo2ucz48c9C/qGmgvLgS9OqIA1sx7nA0xfpIV1lp83lLPqKKIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712158; c=relaxed/simple;
	bh=htjcx65GD8Jzrs3hOJmYNtxdOCyxnrp6510LULE2DqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZY/RFPVRQy6px5h6nDTNxUJvh3yKYHl4sRx/dgmZiR00ZA+sCIxB9up0LvzZqFIaRpkY7hE1ssbhIbP8xlcapu5tVQglcd0D5DMbsozFbVnXXi+fSmQyf1iaHeyrU8kWzNsZ8XMnXeE0SjGF7w7+0pQbWQk+xqfBYVqkzHvlmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2FwYtr0; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2FwYtr0"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd5c4cffefso1374684b6e.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 16:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705712156; x=1706316956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wdj7YGmSg0UDB/6k4CzqqUxQ8GAc3WwpJovB4BRD+g=;
        b=S2FwYtr0wDvvUOViLDIdQKYoNqR/D0vxiZXPhmvH55ZVNq6BlIoP2yIGq4Xy53vaOL
         i4Em0X6jz7/sVx/6aJWcc5dLHsIzKn3nMz1GgGF2GI46bKNqp2XKUPcfyTJPsJ4NpQaX
         GJUtiwiJ5vZTtdpJ/QrYX7EnS88P3le8jgKnyq9C7NwBkGcngvFmx2JVVC2R34lvERtH
         kR8pPmKC6r/LF6uiQcpwj71o4lxdSrUgQy4hjQ0VP/t6bK/xQgzfZ2fx8BQL/Iyro0OX
         r83Wj99UsyKu7fwEhQornDyI7+WFE+YmD/6itKoS4De72DWhAoOdNXi03i0vRjJlVnvX
         y5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705712156; x=1706316956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wdj7YGmSg0UDB/6k4CzqqUxQ8GAc3WwpJovB4BRD+g=;
        b=JvENHAsI8G+IbjgqFdVPPWHxfmr6kSGPqkKxPJ8Jm0Id/E6r73PWdzbTDFUBiH/cN0
         XRppVtf75jeTHZqcKanuG/HnvqTzCX8+UwJI4VwXV++dt2fLfOhItIv3mSwwnAjmST3I
         X2E30DafauWgsI5CNIw6lXlGwPH0XOy3/03+T5rEjU9JRr9pUXd9KTCgUGXa6f1ser68
         bjaB1vIQw+jLOskxdKzkqNC9qOXb1bGgyT/36hqDugSf/RUJhqcoMWhOdcAFQX3I76b5
         kCLsR1KXBxLOkmZl7fiLkypC7o5q090t6f20Fla3CPSy4K52Cnar2bn+O2d3lBphl8Ax
         UIIA==
X-Gm-Message-State: AOJu0YzlGawDVK0KtPVVrOBcFMQOyhBKrKv5BVTWLWs7JA7BIfY7Q7u4
	Jkf0pdVLjSbaZNKxUo7O5hBM2EgwbUVUj96iATKgcoY7R6sn4xsQr+ip8nx92S1kO4uIvf70Hk1
	1T7iVzukLU1zY0yHT4Wa3Y9nN3sE=
X-Google-Smtp-Source: AGHT+IH2GYhPTwkh2qOqAolQYMCoEo5b7R4s9w80TSiT7fhQkg9oO4jkMjlF6dtHSJM7gp08VrZdiRIaz71i7DSXkrQ=
X-Received: by 2002:a05:6808:2f13:b0:3bd:9b47:ca3f with SMTP id
 gu19-20020a0568082f1300b003bd9b47ca3fmr724763oib.48.1705712156486; Fri, 19
 Jan 2024 16:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
In-Reply-To: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
From: Namhyung Kim <namhyung@gmail.com>
Date: Fri, 19 Jan 2024 16:55:45 -0800
Message-ID: <CAM9d7cjgu=Ec0Hd83sn=LkHrHBGciCev=tE1vRKFMhzNo4xipg@mail.gmail.com>
Subject: Re: Issues with Linux perf tool on Raspberry Pi 5
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Fri, Jan 19, 2024 at 3:40=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi,
>
> I thought I'd report the state of Linux perf tests on Raspberry Pi 5
> and so I opened a bug because of the number of failures. I'm happy for
> help resolving the issues. The bug is:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218401

Thanks for doing this.  I've looked at the error log and found
it had a failure in loading BTF.  Maybe the system setup is
more or less broken..?

Thanks,
Namhyung
