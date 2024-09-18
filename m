Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33A189B86
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664445; cv=none; b=RCOZMm6m75hCFK4im0Ls7d5e0kJ/QxlaQmWHc9wQjvRnvBwJFTh2HkCstW9WIFHc5RcAxRcdHpnmggs2f1IQgNUtygPV9b9go61Q0ck63wGjtPKw961xOsoxSOCG9NDyV2+lwn4bhY+ywwjK5o1exEilKVjbBEng0Sa11XJOA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664445; c=relaxed/simple;
	bh=7oYarAgQGycazDkvkKC7WBcvZUwjYr8rRIgQCtcjAvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjJhYQ3U0HEuQBAABl1RqSd1s2InOE5RbxO0j3a7aTUp6mNaRUkRrwJGXANpxpZg31e9nxX8hz9xdiz0cyIODtpagu/mwlffnxILJwh6kevp0GNvFTeDt/flfk5l3SBlwjKnzOe5GpZl4DWEXndkB+PVZPmgYXDOXr6Md669UCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I5czZ58y; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I5czZ58y"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ddceaaa9f4so25156697b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726664443; x=1727269243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTFCOs9eRo+XyG3ykCf6buEoqWSg20vB347/PrvRrnc=;
        b=I5czZ58ykAXU+xZuZjxkzz2GtvB1lnoeU/wYKqNAETi+q6A0YO7MGvLNFEEYPg8lzh
         FmVp6l0MJ7NAIbA3xI5KvRjOJLxM2kdVuuO6LP4fM1A09MHNlBFYV9igT9+ndfcyuXgF
         M/n0m4I2S2VJ+/V+DuH4aTimogyMBMPmvWTeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726664443; x=1727269243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTFCOs9eRo+XyG3ykCf6buEoqWSg20vB347/PrvRrnc=;
        b=lvpD+f57OV8DuC+Q7IUNzlF7USN4HtqAgmu6eBoUsKtcEQziVr5E82CXtUHKhX7NLs
         G5wcpLSqtHsQjghixni/tuwVAJ5mAob9FHncZNiDR7KLtCfRb0fJGJ14BpRNHDxm1cBO
         OgSKuz/pmHP9s5URUM3NSgraeRaCi3RqruVo9YFHqqxqv0yMgZpjejGfrTcvnAilIaWW
         sZrK3q3GzE7Bagaxshum91NgvsPmgWeWM/+4nGmrwIq4SMxlVLp/swq2HCu1jGvsaKV0
         zF/RNxYYWW+drnQnIV6pui99SINlatAqkXoebAvaWnNX3V9O0jKhnCmxoPoUWNWnz9MY
         IFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH6ajrTw/6AfaDKaLkqMC/afZ0vZJi4rN6Z4h7WO/tCQrsKtg8flsyZQFHClvKc+E8p6QVpnoSgLSPzdrv7cVU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0BC784gvIFP2sT7vZ2GolwZ7l6l8b8yTkNw4Lve37zERK643
	UpftzthPUo4ph5ztz23ZEQ8Fl+tw5TiTfVIOSGHiUtwdGJz/wGn9wQCj017sctpzT+A3Sekus/x
	QWnxEJJUZWdQ9RzBzcm+U3x7oz5wAcA8dwzG8Nw==
X-Google-Smtp-Source: AGHT+IH8QHqnY6rEGJEDMNfkvoA+xM+VUcOpc93lVvHh6R+t3tPaKNjg9OKcTz+lf5/gSA0KXCTLX2am7Z/c20HlVc4=
X-Received: by 2002:a05:690c:f0b:b0:6db:7a8c:6653 with SMTP id
 00721157ae682-6dbb6ad2e62mr180282607b3.6.1726664442742; Wed, 18 Sep 2024
 06:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com>
In-Reply-To: <ZurLc9qEjBH9MkvK@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 15:00:31 +0200
Message-ID: <CAADWXX-xNBRC8yAUmCdPxe3W==Dxa_Xi6P_ceYDAEAeKYiqC4Q@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 2:45=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
> Please pull the latest perf/core Git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-20=
24-09-18

This - and the perf events fixes pull - was in my spam-box.

The reason is because kernel.org has made its DMARC setup stricter.
and now requires that if you have a kernel.org "from" address, the
DKIM must also be from kernel.org.

But you seem to be using gmail.com as the smtp gateway, and so it has
the gmail DKIM, and so while that passes with the gmail hashes:

        dkim=3Dpass header.i=3D@gmail.com header.s=3D20230601 header.b=3DGi=
5JkPcO;

the DMARC does not pass, because your From and your DKIM do not match:

       dmarc=3Dfail (p=3DQUARANTINE sp=3DQUARANTINE dis=3DQUARANTINE)
header.from=3Dkernel.org;

end the email gets correctly marked as spam.

You need to use the kernel.org smtp server in order to get the proper
kernel.org signature for a kernel.org source.

See

        https://korg.docs.kernel.org/mail.html

for proper setup.

Anyway, I did pick these two emails up from the spam filter, but I
don't guarantee that I always notice things getting caught as spam.

               Linus
