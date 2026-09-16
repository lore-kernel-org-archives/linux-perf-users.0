Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29C39E180
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575540; cv=pass; b=a8mwjKeJF7e+GIJtBO0rU7JpCSb+xtkMXe6JzLnaWiRNfRHZ+7MVmrTqQLGQ6sL89+bm3KYd6412GOFqcKTGq0TwkPWApNuiTF5rHvA8qjExeJAxFd+hqVULCGZSFS07V9XoEzsxGzgVY85nmy094uJkkkwI0Ej9N2k3HKc6twg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575540; c=relaxed/simple;
	bh=w5MPTKLB/ozka36Nqkc737SbWWuJPMz4Oyqj6MfUOSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U28nrQvnssQa0muI336KpmL/4WSRPG4/cqWNx4SW4nJgk1/jmE0oXUQaOgobOqrcNNZWEON3f2ERIVWNYATuBaKfR/V1v+f2TcCvlN9z62MsrPe7uLgs08VZHhKAup5vAHaG+JmMEspcfyeNHRRmRcRpnQmUpwjZSkXLCTrqQYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=roB0KAiL; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="roB0KAiL"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac8d1dso9631737b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 09:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575537; cv=none;
        d=google.com; s=arc-20260327;
        b=qspj+NBYV2tDs/fSBDlASLiCMgBa/x5RyEQC9NCW6AAqDu0SU0eTpjtQEAnYOSD4+L
         GyLRMY0KeNfsnnpD75eV1TLLe47L5r14K+HQjJ6y0Xr0JSYujD+fNVonZgK9yDn2JQi7
         bt9nDaqj90Bbt98w4p5M/mozoDAUDv6/lhjyYNCW/jvBVq7tzEeDwZmqgqlEczJeZRij
         AGEoY/+rsPA1RJ4mo8otBA/X+lLQV+LslRSHshjaqxpL/HBVVE4BWyWQljcP8ITgVrbb
         +M6ASWQGPVsRLDfe9zfSA8/3cwRXdLxlnsDfoYYJyfH+popJotHSOOWsBo0HhtvAHroI
         igCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w5MPTKLB/ozka36Nqkc737SbWWuJPMz4Oyqj6MfUOSQ=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=LGuL2dNwm07So+tsYtPSjX4ADJWZ30Tcf8Rn0GBN62b5RK608+zFWlKvPuj5x0pgBR
         HFHhKa17jK5ERSkmn6wS9UmM5DGLQBc4WSZ4O73saBFyPY11jmyOmB/FGgE3pkhAa4bX
         RT8zJ8PzTLbIZzMNq/7Gwf9EK/1EK5B6MmKA4/dbcvAynEnyDCWDWgbtfcWwwWhaAQir
         cIoV6Hhm9A/tsfR9890k0LT2SZsWoWYL9Dy40l46Esjh3HYQh8EUyalP81FmbrUOVL6v
         fUdgtM9Z5pVkUJE30nNTD8R5xsq4Z9s/o/fivqtTboo5hsnrJDAK/dFBxhBC5GQ7qnnF
         nw0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789575537; x=1790180337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w5MPTKLB/ozka36Nqkc737SbWWuJPMz4Oyqj6MfUOSQ=;
        b=roB0KAiL4RZ/wVFgNWx7lDmJnLMHWittfcZDvvRzemow3ux2tZnPq9WrFtPb7D2r2J
         e6OT3iQBnTsQ7ExS3/obEnn5/SOYnYkAY8u9HUIOQTLSHa3QH8u3rI/AYePh91+PK3dr
         YmYPNe1apbYYG5ujNaAp8PDaUU9IWqTSAyJ7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575537; x=1790180337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5MPTKLB/ozka36Nqkc737SbWWuJPMz4Oyqj6MfUOSQ=;
        b=PyefMnqntCBBL6fjwW21jrweyVJ25H5lT8yDLQ7548q4MQMXna/8G8lNnJpaYttgGy
         EYQfmLM5hZbz+jSMcQwPO1gKZ6z2Nibgxq2uuFWr2egs6neojF7DXESsxHV181yYgDlf
         4Q9VEPcu3ML9C7rxLz1CChWOtQxAasvkgIhJKXMT6NidO9tBgNeKR8+Q0v5NsSVsVKcZ
         hUptYuhKekd7nHHPzgbAefdUfpJ4zCYEjzGOZm1n8eQ2oX9JgFZ3eVhToXCqEn9FOKtP
         QiTH5YTTxD0/VZm7czTyeVduu+Xynhnyn4TG6Bjd2GryjrY8z3xKxT5GHK1cAK25jalX
         yAqg==
X-Gm-Message-State: AFuF++nwVe134PDS6jMDyX19qBEr0a5yebAT8tMH/o5Li6UEyyCrspoP
	f9BY5dZOWCYB8QqxE2jaCvxLLWG3hjvQXFZWIvLu0pSPpml8SdgrLMxKilsb426tBnSqtB2TMEi
	lNdV/bF0rDsgXADTTyd2MOxDSJFCmka5/Tn89W7NF0BfldpnukwViCKja5g==
X-Gm-Gg: AYBFou3oSMbcfNEuXFUr4OVX3yT/b+qeQ3f1G4stFFzzevtQf938SGacWQXnLZqycM/
	yGmaZMYtuYN7vIcrZfgf145cK0mmuQ6kB0k+07fG8r0rjwzVF+a14N4TaZQ7NEs8VyzhVG3C5Qo
	mg8lknAQj7cda6Kvc/CladqMxFvLsn933nWIVn0CAjN52B5DLD12NwsZZKG0MVWBppA7kVdEf5z
	aY1ZEK6n+bKJAJTvSt/zxcQcD5SE68jbTmGmsaUKo+9EyM0+KEO83YyKZIhcb0c/s/GgKGYHVCH
	HsEzigrDHFY4ICjxyqUiFOb4QCZvIvRchWwuQUOrdjEy7KebTYGg0eWoSD3zlRmOmNeQgz+oAwV
	lFXSIuu+NA70=
X-Received: by 2002:a05:690c:c4fa:b0:894:4ded:2746 with SMTP id
 00721157ae682-8944ded2c07mr490757b3.36.1789575537294; Wed, 16 Sep 2026
 09:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-3-1d3360e21f07@uber.com> <20260915185430.B345F1F00893@smtp.kernel.org>
In-Reply-To: <20260915185430.B345F1F00893@smtp.kernel.org>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Wed, 16 Sep 2026 09:18:40 -0700
X-Gm-Features: AcwNN1Uy3Zqq6R4enMp4Fli0DczTZO3ER4_1FQ5ycuvVfC9y3_e0ol3-NJdyleU
Message-ID: <CA+w=M=RVrr4Ek5EkfSbuFGNAOMsQQ9ZJ_AKeyyXJ78rupAa9HA@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf script: Add --lazy-load-symbols for lazy symbol loading
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf: memory exhaustion in ondemand_read_name() via truncated =
ELF
> --
Thanks, this is valid. The constant file offset is intentional because
each iteration rereads a larger prefix, but a positive short read must
be treated as EOF. I=E2=80=99ll detect n < want after checking the returned
bytes for a terminator, abort the lookup as a truncated string table,
and add this fix to v2.
