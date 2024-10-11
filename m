Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F6193436
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682659; cv=none; b=WA+eu7smEFkdbPu6f0BPARA6Fiu2kstbLkALuIDTYiJNVu8OF7nihg3pb1A0IuMEqsJ9OrH54jt2oDzr3wCe9hmu7uqCQy+iZRiQVM6hz/XUwuT5DljTujVHAlLbdN5EFgOWjxIQ47RnC7yzy+7q2GHFATq0equOm1p+qp+B7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682659; c=relaxed/simple;
	bh=uT416x4idzG/LIvi7H+Z3uveTxuB45v5U/dbqVvFfD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/VZvSRhNfkgxvfSSnC23Xt9mQHc0G5XSAwJMiYJHg4FurHUoirpJn19pLagFGkfjGjNslLfFYvj8MVsl1XeCEdEsVZkzzzQaBcrpU2JchKOOkXOi3vTw1LkwdZ9CKV9Zt4nejufgMI0iH3y1biUmXM2YENiNgIclwYgEmHHzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVeQYYUX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVeQYYUX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca4877690so16065ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728682657; x=1729287457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGl9UKkBLbBRF3bOpN663cGom/GBm74RsAwBEoSmDTE=;
        b=DVeQYYUXonJaXLAwmaVE9XEdqGhfiXcp6dib3UOSsT5aUb+LhL8tAbw1Et0rL+s8uz
         4C3+LNjmFx0YHlCVEGkmOrBCPYKrX+GO1O1f9l2HPqfn/1luceITRoBHrcMMU2/rfe9Y
         BgHg1TTPXNZMwC1Lj31Y8csSfwv6KoQAcweNONJpRNeg0YYMK4jlAa0MUJxW/eijrclu
         dDZUlYCczxZ11n43fsQfulU61Xl9Kp2gY0Bu3w/V33Er60CFbP4pcnqlWAZu6s+MW+04
         8DnITxG4YOfgdx3Dl0/wWYv1bRSks+GYCNtmlTgdvteGDDyajntPPSLRosvzln2EgNN9
         GfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728682657; x=1729287457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGl9UKkBLbBRF3bOpN663cGom/GBm74RsAwBEoSmDTE=;
        b=TC/qCDigcHJD2I5VZh3c8RN9ciUxYTOUjOwpaDXYoSW6LR50CskvDxlgu/wzhUANP2
         R7173CsxQuOYfyUHUch7O3MCLyNwiDlPmkSajRjihjQsbQFnEdpuXjwZgfM2TziCMKqM
         gsL0lZcDejjL1VJBoc9E4s2Ma2N3r1vizOtqT/HUqWbhWDBV+lnveKyZ2+B3xpnq7Hdz
         /4krpt2eKL2BR0jUhev0BUddGz6nu3mMhsViLMOTVUrzTxkDapFe/wdyImi9gmlZ27vO
         2Y/59HlYZ01ow4Pxpmuals2q+F+YufUYWXMOmYFFE3soBM06ywXg5G+tn07Z9CMixY0e
         0WRw==
X-Gm-Message-State: AOJu0YwtvO7mbr3p5tkWx37yueIGZMwZ263xmfmE7JliDI5mK37zZmQd
	0uUJn/i4yEJua4he52rcSOlpuPYiHu1jXg2SIOwSZgxiHUbTddqu4rBhOpunb8Eis4d1fG1OqD6
	9jS69wrOtzPjasOiKEnwf/M7Nop3R3n3w7e2D
X-Google-Smtp-Source: AGHT+IHSxGVM4vA6DcGQzLjii9b/XQaG2KX+QNs+qge0CWRvyEcylawZrN2RztRUDt2RKIVrdj6I9/ylZjtejl70U4o=
X-Received: by 2002:a17:902:cec7:b0:20c:a659:deba with SMTP id
 d9443c01a7336-20cbce223e3mr796025ad.4.1728682657076; Fri, 11 Oct 2024
 14:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
In-Reply-To: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Oct 2024 14:37:24 -0700
Message-ID: <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Yunseong Kim <yskelg@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 1:24=E2=80=AFPM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Hello, all:
>
> We are getting rid of all mediawikis and replacing them either with archi=
ved
> sites, or RTD-style documentation. The perf wiki is one of the last ones =
to
> migrate, and I would like to propose that it is migrated to RTD-style doc=
s.
> I've done the initial conversion from MediaWiki for your review:
>
> # Initial conversion
>
> I've done the initial conversion and the preliminary results can be viewe=
d
> here:
>
> https://www.kernel.org/doc/projects/perf/
>
> The underlying git repository is here:
>
> https://git.kernel.org/pub/scm/docs/docsko/perf.git/
>
> It actually contains most of the wiki history as well, excluding media.
>
> # What happens next?
>
> There are two ways forward:
>
> 1. You can clone that git repository and host it on github. This would al=
low
>    for a quick readthedocs.org integration and allow you to edit the file=
s
>    directly via the github interface. This is a very wiki-like workflow a=
nd
>    would allow you to grant access to the repository to anyone with a git=
hub
>    account, plus accept pull requests with modifications. Once you have
>    readthedocs.org integration working, we can configure it to be under t=
he
>    docs.kernel.org domain, which will allow you to remove the ads from th=
e
>    site.
>
> 2. Continue to host it in the current location and accept edits via membe=
rs of
>    kernel.org and patches sent to this mailing list.
>
> Please let me know how you would like to proceed. If I don't hear back fr=
om
> anyone in the next few days, I will configure the perf.docs.kernel.org wi=
th
> the current converted contents and redirect perf.wiki.kernel.org there.

Hi Konstantin,

Yunseong created:
https://perfwiki.github.io/main/
which looks superior to:
https://git.kernel.org/pub/scm/docs/docsko/perf.git/
as it is using markdown. Compare:
https://git.kernel.org/pub/scm/docs/docsko/perf.git/tree/source/top_down_an=
alysis.rst
with:
https://github.com/perfwiki/main/blob/main/docs/top-down-analysis.md
Perhaps the solution here is to make perf.wiki.kernel.org a redirect
to https://perfwiki.github.io/main/

Thanks,
Ian
