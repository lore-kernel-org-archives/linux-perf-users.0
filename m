Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E92BF014
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122035; cv=none; b=eoQ3raNxSLW5SstYzdpJ9K+lsrP76O8YkCU6zDkTvuZULPCoC4Rpy9sj4tFSAK23H9CusTnDaeTT8+/JwZU0aKyuFbZyJvLeu1KwnY6Dd4HAlogJE9iIiWzud5szhMVld0I6mgU4DvpQ0PN54kWGk8uYmtOKMGG0qczdnlDbHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122035; c=relaxed/simple;
	bh=rCJZ6Rqv6x39AZNnhWIkJ3xXooq3Nkcuhlj6QT7sXAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/QFdbBIbgaUzQgtr0Aax5G3Xak4TdsICBxzc3TgrEFqAUA/iiqDqQJwzWqTmp3oJojqGwrfQiQTdG8TzEstR/kgaH89W9/7O4WjGTPbVt4A2ggFeG7qdzqLFcyuSxuAlj5fmdb3SAkrOo4Ye/Nmi51W3B85pGyqYc4sfedPVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzMzvQDD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzMzvQDD"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo61225ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750122033; x=1750726833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCJZ6Rqv6x39AZNnhWIkJ3xXooq3Nkcuhlj6QT7sXAA=;
        b=HzMzvQDDfGXc5/7IC+VX7DKG8SpYVPDW64Sc8dzT7ARHUaprYOBzHWsihaI0tfwTsg
         hs9jrGi30QZDRCMBcLqjHnZduLczhCPqLXPDc4UgxCZHp1foAZtJGqnLGwAt4sbg/nc+
         o7B0jTLj6/xOS+H/U60nZzFFqHCKpMu/TUtLB4ziAQH2jkER9q6g8vmcw/28B0QtEnP1
         bYXVNUblPIXbh8A3elsleVXcL3onUn39XHFzGMOGvQBEIuWj9X/wqFGYfWizwAxPQF8M
         MpnTU3V5oef0rTBgsuouYi0K97aT6hLDCgG/8rbrx5ZpLi42KVB6GVGUoz9QdebWQmkh
         Xb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750122033; x=1750726833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCJZ6Rqv6x39AZNnhWIkJ3xXooq3Nkcuhlj6QT7sXAA=;
        b=f1RHbNlFZZ+rD71wm24vk7qUj2IBEhCei0tdOaCZtfz9kwX3+l43Lv396V417Q1jNd
         77N3F1VfPgG0HUOyU5adKH8LQHBGz2UWiyrcEEk88kOmKnf+hnfta88uADMkLCwU+0Mw
         J54JMuLw/gAU2efvx9bBDqCCEVslCOlYVyigcfHpzFdswlcbA7oeQyI3OYtPPZkjM5qE
         ucBWNVqwL693sPOF8FBSUweiQVcHB3LIBflbvWLs6mtEKFaC9V/fz1upg9SBfyaQVpBp
         dv1fBObYDGrwKo5ltFmQ33L9H9LnIOXfKpJ5fJ9bZN879Dt3PUiX01bnhMi4x7jDda2+
         KhnA==
X-Gm-Message-State: AOJu0YwPE2yIQu/Y6EAhhifDzkvy7zQ2bMlOBwBoFRkiSFTqut5tketQ
	XaRENxIG/97NysXLJrBbvNES6hs2EchNamppPgGSuTRM1UPytCkRFFAA3rRJABeNNWYwJTHh37d
	Kc8wpYPpcjEsmYsj3ENliP2lINIb0UGQ3hZak+vYC
X-Gm-Gg: ASbGncscvifVlTlJGhYSj806yRVSemeI8cbUuf2WMHbZLJxzrXyPDhjNxwyXZCRVLYi
	tZjgF02wnTPbbo5+FES2ZJ/rppD2Hih9gCATKU0u6JwaqmKa5TRZJuq0RBkxUp+7uHCXStyb3dy
	J4ztMjNYiXbsrKsiGpiOJXTzHEEz9AASwWAREWXPiaw0iZ3NK2L6Isfl6b9txiWN6H8GVEVS0=
X-Google-Smtp-Source: AGHT+IFWGG1GvEPulDx+6oNJ7f9HQRdMOh99zpdWks3kbOikvI4fMesxkMc8GTdGuC3PYyPK0BdP8LykZjEQ8Q2gM3I=
X-Received: by 2002:a05:6e02:378b:b0:3dc:7e19:fcc4 with SMTP id
 e9e14a558f8ab-3de08d958aemr8594435ab.8.1750122027976; Mon, 16 Jun 2025
 18:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614044133.660848-1-ebiggers@kernel.org> <20250614044133.660848-2-ebiggers@kernel.org>
 <CAP-5=fXLCAN_8PpPRYcLpLXG0oPDqGMzn8VwuxPdg63+zFNTUQ@mail.gmail.com> <20250616011353.GA58711@sol>
In-Reply-To: <20250616011353.GA58711@sol>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Jun 2025 18:00:16 -0700
X-Gm-Features: AX0GCFuoBbLWShxHQk1-i-SRmkr0kDu5TzkmagUdaARsIve2zgwyVQ68YjUwUV8
Message-ID: <CAP-5=fUA-AvH29tS25P3-C4U9Wbou931P+A-K=yTpULdxcaRbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf build: enable -fno-strict-aliasing
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yuzhuo Jing <yuzhuo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 6:14=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> As far as I know, the packed struct method of doing unaligned memory acce=
sses is
> obsolete these days, and memcpy() generates the desired code on all suppo=
rted
> architectures and compilers.

Thanks Eric, I sent:
https://lore.kernel.org/lkml/20250617005800.1410112-1-irogers@google.com/
let's see how it goes.

Thanks,
Ian
