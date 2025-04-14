Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5B1A2393
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667968; cv=none; b=LeETpNEz77clanoPcZb0odyJVrKDPZinTZ/jUhb4DdDOgvMU7zZwIDgsRa7If6mP8eRCrXhuClGqKZobPOG40rzksZ53gfhSSCzwexJOl8YtRNFZn6TyCRwtaLbrr/ZnUdLTAQ3dNZiWb5mtJd/WX+wTH0/gUA2wUPuJxurnaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667968; c=relaxed/simple;
	bh=ImMwghLZclk8jc8CraDh0vr/LBt4ZfaZ5AReBJMFt/g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b5itxL3IsJknCivXyD8UUu6Qjk6DjEY35yt+97cB7A/IparU/+AB+zexKhw2xQOSLzTCTJYqiVPd5hN7mX5QEy0sz8K+b2OwPcL7lJh5xkFIlSrH1djiQleG/VkL3C6tOlfmF5u8SDeMmM6l5j5JbDitAO2HqHZcG8+iXz5YoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2S2AyFt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2S2AyFt"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so4473a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667965; x=1745272765; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ImMwghLZclk8jc8CraDh0vr/LBt4ZfaZ5AReBJMFt/g=;
        b=z2S2AyFt0PmYLKnp+e4r0hYahWyS6R69e3bkFH45BvexGmFas6/m4Kl6Hvz4rF6UM7
         +poPehRW6YeySAA3xJ03Hxe1bMRhkm+fKVlv70Gye3yvbFNb38SiRI0Lqo+z/UnEjeyl
         neeQArSK3e7YUsSuIJoYpSDASPAGLdyw46PkImGOsc7S6PQyO2avxYnkvFeyyOVQ67Ft
         8MqGHL6XlUkeLYs/Z6FZ821ANIwIPB36VMjlJ5WvQKOoPbrAiTY+QNzDim9ApSl/7VTr
         1YSxVMkgWeaMANL6wg4bTXnLPqxnFx1lpn8oNE32a+ZUZMZ6EO3+9iHR1rgFw/RCA1kS
         7wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667965; x=1745272765;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImMwghLZclk8jc8CraDh0vr/LBt4ZfaZ5AReBJMFt/g=;
        b=DjQJ1uU867t76CoeoXh/OOnaGcqoGCjbIrzPsrTnOrtzHveLfYZLSxO35HFBcEeOEB
         uJsMIJZVz4I+iRqBQEPY7Ml0GhMhGIFiMWl8RG24KbBAJHSCeieNtb+HWvvWBhJ6nM/h
         3ym5uTg1CjmU04ti4kNHHQ1gTodLue0Wq3YE2PznrYZi1wR5GTrV0BpNhLz7t0tvK9OJ
         vSkrk+aT+atMtOHP8Qa8qUGMfLDtzXQa3sXuiBpND+wsDQXtoWaDeXuKcR7SQlJa3p52
         MR/Bx00SwdvsQ8Y9YO5Pk0bRudxSIKgkwTvtUbx90cvLduuJGkApnt//uuc53mSzIGyg
         lRMA==
X-Gm-Message-State: AOJu0YyRAj/TCjmdCGwHdsALMoxHD838njJ74MVCLFrrjOSb351SMOnQ
	JAv8Q3HjH/XLDlXQ+6a28kcPap6lt0LK8hI5A71SXyDnwxu3jIDGO6b3+NQAqSfn3Dw3RkpMHIm
	lqT0dNMiopkTT4wfx6/xfh9X8JXfXKu1KI95J3G07C1HtIHFhUD/mZyg=
X-Gm-Gg: ASbGnctFhG0C0P9w8qxd69blFFS1ER8S4Xjc5cHB5/2HDlSaOsEMiGs8b4OhT06CH/W
	+Bb1oTTLVeEREPVVE+qjVnuAL11qGtqeffGMa+s89y+3F+Tpa68krfbwwy4Ci3hy+a5ROPZF/NY
	fEMbYawhIYe5t5IF32yNqq
X-Google-Smtp-Source: AGHT+IEy+/tSFwETrM7Kkoogx4LX8L7QQct1GGZdDh26Quxh3tRBYM+6/kx9oZKqgTsn23m0/zbPlnhrJoS2OYD0/B0=
X-Received: by 2002:a05:6402:b4a:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5f45f6e2bb6mr22701a12.2.1744667964513; Mon, 14 Apr 2025
 14:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Todd Lipcon <tlipcon@google.com>
Date: Mon, 14 Apr 2025 14:59:13 -0700
X-Gm-Features: ATxdqUGJq91C0oqwIRi3w8g84y021aNchwztSuYFkxP34x9Yqg5VAkUlXcr3X2M
Message-ID: <CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com>
Subject: perf script intel_pt decoding reading instructions from wrong shared lib
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

It seems there may be a bug in perf-script when processing intel_pt.
Specifically, in order to reconstruct the instructions, it maps
instruction pointers back to DSO-relative addresses, and then reads
from the associated ELF files to find the actual instructions that
were traced.

In the case that the ELF file has an associated separate-debug ELF
file linked via `.gnu-debuglink` (common in some Linux distros), it
appears to be reading the debuginfo file instead of the shared library
that actually contains the code.

I've posted a simple repro here:
https://github.com/toddlipcon/perf-debuglink-bug/blob/main/repro.sh

I haven't dug into the code yet enough to see where it's going wrong,
but figured I would report to the users list first.

Thanks
Todd
