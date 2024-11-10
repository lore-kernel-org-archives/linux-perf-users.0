Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DF1459E4
	for <linux-perf-users@vger.kernel.org>; Sun, 10 Nov 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731280835; cv=none; b=mhg+cWso9BWSnjuJ7dLj+EU7LqnDzaNJWxnDmwcaXZ5ZKEKDnP8fsnZWPLO2Z7/A3B+Dr70KjgAGEZR7Z32ERY/lPif+9bg8+BcEOwp1iEl8PCC7YHRlmirWbfp4IWH94LMPUvahPnR64A4fRzf4/IuS+O6lEbC3iVoYISNzWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731280835; c=relaxed/simple;
	bh=KUUgC3sjdRR/U+OMJ4PIdpSI3gF0xSHZfes51LZiWMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BeOjXv7Yd/O2zLRPj+Tqw1Ym79Hc53wPJQ4urdVo2VPGY9r3+MzZqTdOG7FMajKkpqh2MbXtSXdki2lNIfc5nrkTwYmc+XEgtXBFAn/EMujcJqdwTT3dFW4S2Yb+QRGjsAtj7KplJeOm687mAXVMtuRfKGZpv6w2fN5mK42modA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1tXSDR6; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1tXSDR6"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3314fc5aacso3471900276.3
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Nov 2024 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731280832; x=1731885632; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=03TFFkX37x8/RTsZa+UosRIr2SY8pnCYQHrPLwTZtOg=;
        b=Y1tXSDR6mmh+YwmP3r650tC/phuq0J9goLIFlAh4jHi4nctRWztkhB3ifJ5b8z/t98
         F1G1S6ICgEQfEhZ2mV4ZHSrEw6Z7EcqX/YPeeyrvs36ElchH5QLLKodPAsnazZ9j9Npl
         70fJGpkrMsV8oxuxKAFLQEJsxxsrX1DguTlDtlzjwkqnnV97dP9DZtiSQEGb7ZM1byYm
         3owzzjCNjpkOXHWCpCiyCzU3lTbdhv2s+RoHUgFzu3vv41wznbPj9iLQyg2KkJ9mf53Z
         EOOEJ80vJz8vc4uGkFPxg+3Mua8HnGiYc8cnUtnCPxmqpDHPoNblhSUlqcnGQd41Kvej
         2tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731280832; x=1731885632;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03TFFkX37x8/RTsZa+UosRIr2SY8pnCYQHrPLwTZtOg=;
        b=UR5rDm5MRWPyk0yxYeAesXLeQoLlSz4KYPHJJAc9tIddTqbfQkUkU/v30jpEb56KGM
         2xURP8p/mU6HF1oFJS1/PhD7cAk90QzCbmx1iFots5KU3vL0axWH+K5wIAyOiX+kD6p2
         SUpMvmTM1ZGhvnVMSW0HrujIkZKwzLQHlSqgGlJe+aMfln4z7ejfqo+oKbQun8JG+heI
         R7pKlnX9j8zc9vjP3b2pulfK7E1iMwiOieeR9Pz6gbO9D/ybL00QAdJxQ5cmXEttdzVU
         DtaRJ+fseI0sb/TVJP6ukVtmp+9e7Wo6DJmXtg08ecCZBpeyY987U1/bPt0OPyCQ1IWZ
         vnYQ==
X-Gm-Message-State: AOJu0YzESq1ySdm1CcU2TI8riZ/fZTT6rQq7SXb078iTto29y0ZQS35P
	i5ojtpwNFTvWpOWQtKK68f8bKUvhL3TzEPKKEfxcUXYX8Q9u2OSeQuh2hwtxl4qus75qnh8+RuZ
	Us1cA8kAeZOcI6Llc/T6w/DpFcozpab76
X-Google-Smtp-Source: AGHT+IGuFNQYyzjhfIkrcFcWzNxgmQ6Js+OKLp8pDjbWh3vV3V9ZFE6z8hxijgucLubhECa3LFDZs6RleaCi1n3npOM=
X-Received: by 2002:a05:690c:9a88:b0:6ea:85ee:b5e3 with SMTP id
 00721157ae682-6eaddd73a0cmr92747427b3.5.1731280832633; Sun, 10 Nov 2024
 15:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adam Stylinski <kungfujesus06@gmail.com>
Date: Sun, 10 Nov 2024 18:20:22 -0500
Message-ID: <CAJwHY9VfBAc8fWKtPB9CZA3fSj+UaTxMBWz_DtDRt1vYf09GRg@mail.gmail.com>
Subject: perf-annotate now broken on DSOs
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

It would appear that commit 873a837 broke annotating symbols from
DSOs.  I've filed a bug downstream on Gentoo's bugzilla about it:
https://bugs.gentoo.org/943203

I know this fixed a bug (seemingly with the perf mem command?):
https://lore.kernel.org/linux-perf-users/15e1a2847b8cebab4de57fc68e033086aa6980ce.camel@yandex.ru/

But, the fix seems to be a bit heavy handed.  We want objdump/capstone
or whatever tool to disassemble the function in this case. Commenting
out the return here restores this functionality.
