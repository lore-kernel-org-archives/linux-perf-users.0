Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E7302CD8
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164168; cv=none; b=BCm4x2LGh1qalVeogopRmtjL8w+DBP/gu2n0vg7PLR047oyLELTUH4OdzXBC+DqHudaaNKmadeaZNnFQFta5JFOcXK7Fu52rI8pSQrqjUAVTUa28LQNrN7IpBr/1jy5PWQ4Ugd3xjpnmX3pcJbTyqVKyIUt3SASWxp0bAQQbZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164168; c=relaxed/simple;
	bh=wqhYEdtYkGwjLIFqEJnVEAfzy+uYEANRYzFEWhmoU8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgUmeCU60RiJmYRa9N5BQOcQ4+sP7J64azpY2SCO1jEh/55hDxnHArJceXM83+JnKt4igsokYaeCDZ/cTB/Dcd+VH0W8AnRGFR97LhooEmubj6hdatJjaiw6eAiu2s1v5rKohQbpU8tuhYZudycLEK6mmkcHPgO0l/zPhdfhmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTa6aaPv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTa6aaPv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b47f662a0so1758253f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 15:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763164166; x=1763768966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MOqayRQhdzTWWtGSNjRg5DxZI7H2LMVGi4pIqL6+Qa0=;
        b=YTa6aaPvBDHqO9TnXzKp0qVXnQ9eYABoDhQnTW3GVZ7NbCqC2Q3eTYpjnWu9G3nYrC
         v+ItlOgVozeuwXj0C+sfDYAVc4i+SIdpVPgM2I28Gws/BZ/aXiF1494KEzLdHCxOps/y
         DzUhrMiOdK9g1OHXMlwaRuGA35K3ttFZmPltLhkmVBQavh/rbONJcrc2GAI/T/8Bo4Ik
         pSufB2F5TLC7EE15i37l+2x1HrXA1TeQqK8xPo5OAkNgKtNa7hEsjk4Oj7qlA+di+Fb7
         3r+knbJTJUegQQz3CC8+Zje+gTwV7mfgFt/hVc2hoOOsVj/Dv8P8kdUBhOOkCFISdD44
         kfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164166; x=1763768966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOqayRQhdzTWWtGSNjRg5DxZI7H2LMVGi4pIqL6+Qa0=;
        b=SI09GGI1hwn/xnnn9cye5VIkvsB5N7Owvg+28A/wKDfYMEM6UwTUL1vlqQRKgBisOa
         ULVgYc0d1Wvl3UHWLDRzPAXwB0mdLDelBeNOF9BtnlP9y9jR6TRF0Z36kOmOkzpp5KNs
         tphdw4n1rASsi+rY1SktST9SqV4cDlhdkBOLfRoT3kl7G3Gk15vf+jyyp+eENRcVQ2dB
         +EQ5YlAxtsTJgbvmY0bxt79gDWUVBBMl4s4lazwbL/w+ER0AhlnLdVEaLk8DyLR0rk/J
         uXO7Ko+YxQO+Vzo2P34RT6P/EAl/i3WOJxvYe0TdA9R8w3uIIjVLSG7XwP/zSu4zn/+O
         wJxQ==
X-Gm-Message-State: AOJu0Yzzu3F+pzxHvXjBknbI4z62L5x3HrhO8qFowRyTUYe6RGpioM2G
	46z83DMh0wvB3Z441MXo/T+H+jM8lXmOAh1VNEYZvL59WoFBmVnN5ysEN3brb2ix9mq2jXzPdkj
	qD6tiP8N+5s5c6+WRv8HgKmRTINUSZAb/tqcmgmg=
X-Gm-Gg: ASbGncseuWMkc88U6EBNEgprSBEtlsPgivTiwSRBykWetj8y+dVL+yvNjMTp1V3AbQf
	SP9G94iJGfPBvVRsIhNB9oKq+Ouf5X9d62n8bAaNg1Fv2M7IdHEsLZalJVRe/YMXQ60U/GFhOow
	rVjEvybzTko7aHKo0fCnncAW0AZ/0COGUm6HA9nQUoJ66Rsk7uZ+AAzfAmFR5AucMK8Wa59CA7L
	vnY/w6DwJHJ49+RNCGIg9DDgLVQCdAhgwQaC25SPdqSy0XGwlacyNkM90ZqwUBf8UtuG0PODGS7
	Zqk1HK/NHIGk+7ID46yA3jx3L3bZrMLIjmIifwyIOlEhW5VhRIvtEF/bAitK+hLoq95NJch5alj
	1IVtmJxYiU5rA7LtMp3xzDl/6
X-Google-Smtp-Source: AGHT+IHLI1fEqeCMXOHsPc3KUnHcaLTMu6dlrYfq7MtKVrvVLyQXOdubo9J14ldaYXYEWcvGx8+vZduAiXgs2tgiiec=
X-Received: by 2002:a5d:64e3:0:b0:42b:3dbe:3a37 with SMTP id
 ffacd0b85a97d-42b58d7925fmr4781527f8f.10.1763164165479; Fri, 14 Nov 2025
 15:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <20251114092914.217533-2-namhyung@kernel.org>
 <CAFjbc8FK_qs9XqMEf5k81VRNCNXSyda=VUSuJwp8LALOq8fGvg@mail.gmail.com>
 <aReBx2jFezxbhWt0@google.com> <CAFjbc8ENz1AhCH0MBMmcrJB34GvjWPjzV3i0PEfnsTAampe8-w@mail.gmail.com>
 <aRe67vqAUlIEo90-@google.com>
In-Reply-To: <aRe67vqAUlIEo90-@google.com>
From: Pablo Galindo Salgado <pablogsal@gmail.com>
Date: Fri, 14 Nov 2025 23:49:15 +0000
X-Gm-Features: AWmQ_bmWsaO5czM8oFjAWvuJfhjGDaKj-EBuIwGM1npC8d6-INTvxte01O4MH7g
Message-ID: <CAFjbc8EqLdtb6LBbztwnHgvk8pGWJG=vXJ-_E4T-opJzazcUzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add python JIT dump test
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> My concern is platform support.  Is it available on ARM and others?

Currently, it's available in x86-64, ARM64 (little endian, 64-bit ABI
only) and RISC-V

> I like this.  I guess it'll return False on unsupported archs.

Correct: https://github.com/python/cpython/blob/f0a8bc737ab2f04d4196eee154cb1e17e26ad585/Python/sysmodule.c#L2442

Pablo
