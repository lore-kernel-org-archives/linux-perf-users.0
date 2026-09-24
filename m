Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA727A10F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259213; cv=pass; b=FGyVWObzkJHVrywcrZdJglNIw5d3OIqq5Lsd7x6gSEuLzGHgvi440DO5TPuHr8muZFbZq0KbZTv0hayYOjdhXEcOZirB4uKsabH5J+3VR+/kozfiqBewfvPhCAPeXR8zx0DL8Jq7Mm1mcDZdA6lAyO4NsxtHJ0A1qMZsTsVJQLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259213; c=relaxed/simple;
	bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiJen8QoQdp5TuE3MmvpeAcwS0m0Qlq5eWM8yK721Y10UVcOpI4/SbLNl1CqVUSUn6gAn14QWkmn9ilVTA7AEwap9KWGXxbAXhxxoc0kdWy8YSxNmKrmr3SU+64LXfK+itvqcut5mOhbAKLo1ZzIIMpytebONICExyOmZpg6+RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UbdL19h3; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UbdL19h3"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a803458ba0so2784039a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 07:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790259210; cv=none;
        d=google.com; s=arc-20260327;
        b=pcSBwsuKdtlpMMoh0I0vZnP9IIGW1UyqBPMDQQNlAESnC/VfJeEH72YeDqwbIJNSQj
         OoTZHpgcdO8Wnw5VTrS62Wrd5ggUHdkeBxvAA0oEfZpIuo/5tK21yq/4xHtwhfH4/kwE
         XTzLLKI9W2rfOePt6UYB4uzwBumBiB1JawQk2JA01aY5dWeGUs/8hvH//mdtpT2KfIoR
         iFUmPHhEG9DMxHKtpNAFIljCOVqGDeYLI/GtwBHaN1dld6kmYCX69zYnHvS/2jirIRFx
         qmrsNVL2+hqoRs0aJtRWcFdv4BqXowHZ2FZxcwPZZn1A6m6KEICLY9gW7GdfQBY/g18b
         ryQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
        fh=IhstYSD/mIDA/R9bz2gJlcOIQ9yVA4pMVv296UYyTIA=;
        b=Ey1M5/jsTYmDbuhYa8NBna/4ALZ+kfWtAcbl9+HdoeDNqRuBMDHvw5by2m0Os83ov6
         6WN/sZ3aPQXWw4q3mJHPSYB/6gAqc8jJaiyklk7WyECtxCGMEwdKb5VwGnrPkTh1vqyR
         nN7ihryxfvDE1dAkQbVr+DUKyTvqm49ERF8KKgjdfSyWdkF9v1fBE2CORuFDTUjdYXwY
         NsoEqnJGsKGsz8jU6hTr3xOhcwRxb2PjlNhS3sHVHGqu/gjaSdHHJ5R+yPznjuy9cP5/
         1fAWXzC44Rw5eCYSdBi6ENZkW+Q6oFOLSUipra/HJS26gE+EFsbZvoqUPSXKf0o3XMGV
         8RQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790259210; x=1790864010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
        b=UbdL19h3yFY6+RMeRRcn0pSvBbwBZtt3bR/DDc7oUnz9jRCgedq8PuTxrXMbb05RwC
         KuIbkJi+Qh666ILqzA2CkmAtrEWHQa2XBbRV5iYdZSgyoxyOX0YgRBCXDZ+DToREuMvP
         SqMfW4rFXdHGQhVZrcKajwT0GcEB0caaN4pO6jfkKFR4L7VKHo8an9/jbE4CTzXYoRI8
         XcuaemRfxnpoU/vJE2thHZMMFatDk0oQgxVNSepr2l11FXMji0vMEO0CWlOADtyG3qHk
         S9VVyNJYRtZrV+3ueMu4nPIfZK8BNhhcjgqklObED7flFUZkn/j1WK61lYswM74kLw3q
         aiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259210; x=1790864010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
        b=H68B09+csbVssmASHudXLWpajwd4lpHk12bWKJctpwuhVEAMDIy9dVxc6/JmdU5WWX
         hlBWFhGOClDM3z75xXzLFnsksxx//BZ+XJrms2p0TWa8nHGYc3WgJGmIsKXqt8TMX2aG
         qXWyzSat+u96qZ+4DIBb8FtCUTkw8GaWyuEnIX2ciP+RmBEmKnWHeiIg++Wa1ZQiN1Mk
         4hifWIHsdNjpaeVW/wRehlETLL4VXj8ovulkkmWYZfPgYTJhFhqEeIsrMJ4piK0xCmNo
         gQhDCW51QYt8N2Y830VjzBl8O2jR65YT6NFcbJvdIfFb2Z+/C2Fovye/emi3RhkJsLQY
         iUDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCIbdkuZpr8dUq2nB8d1HvoR1kshHdfpcUN8WXbbCYvCvauL5iHFg3QYurzLv+5VoxWUB5y6aldoQ/pPVjM89o@vger.kernel.org
X-Gm-Message-State: AFuF++noq9aLqw17x5TUdXy3WK/kj6wFqFa5ZWgIZ9BZ9aNSMHcB6j6l
	fR7wtcAxOzgXAaqgkk1Nxt4FXgTH6S0dLUhdKevwOsrgvfiEMxrEiTG6RjYz9OOd9Cfd/nJPMAz
	ObZUrnJa9WdS20T6pVtK9d3jkJx6ex39pF3/eAUs0yg==
X-Gm-Gg: AYBFou3vDkYKFL29n1K5n+FbLX7iCoU40IOk5XQZPtLkxlyCLmr/rUppUBB6i1jBVr7
	eyY6fP445e2uKj+ECUYGRxkBp2tyM9cNEiAD9VqTzp926BktjQblkScQha2Ce4C3ppJv4BFEuB2
	4JLcvt1asgssl7fZo2NAN74ZSQpUv5mKF8lZdGMAEp7zIuMsWkFFaIt4G4KoP07trRrnWxxjHJZ
	ft+gqnq4e+1fecYw0S7nUMqIN88hC35AxoeHW8CosyKp+XZv9GJ9AL2LLgIUU1cPV9PzmpyA1Im
	JwWJjxPGB4KBeHcAShlMxaOVJ4myCy8TK66fEPRKCAD8693aJbaIc4fD+w==
X-Received: by 2002:a05:6402:52c9:b0:6a9:984b:4c71 with SMTP id
 4fb4d7f45d1cf-6aac90dca01mr2240458a12.33.1790259210418; Thu, 24 Sep 2026
 07:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924100106.2054127-1-zong.li@sifive.com> <arUSRcgzWurL-YrL@8bytes.org>
In-Reply-To: <arUSRcgzWurL-YrL@8bytes.org>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 24 Sep 2026 22:13:18 +0800
X-Gm-Features: AclHuK-bIWWUadjBwDkFnhXkUVbzOHGI5rymQuXxYOn79n8X8KsdtkoE0POTC7w
Message-ID: <CANXhq0qL5qwejCXcfLNYfK025AYaMbMOzf=p0EP-NOkThL30Ug@mail.gmail.com>
Subject: Re: [PATCH v14 0/2] RISC-V IOMMU HPM support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: tomasz.jeznach@linux.dev, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	mark.rutland@arm.com, andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	yang.yicong@picoheart.com, nutty.liu@hotmail.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:07=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Thu, Sep 24, 2026 at 03:01:03AM -0700, Zong Li wrote:
> > This series implements support for the RISC-V IOMMU hardware performanc=
e
> > monitor.
>
> Do you have a link to the specification of the HPM (and additionally the =
IOMMU
> itself)?
>

Here is the download link for the latest release specification:
https://github.com/riscv-non-isa/riscv-iommu/releases/download/20260222/ris=
cv-iommu.pdf
Alternatively, you can reference the GitHub repository:
https://github.com/riscv-non-isa/riscv-iommu
This specification includes both the IOMMU and HPM parts (sections 6.19 - 6=
.23).
Thanks
