Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE943AB7
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105275; cv=none; b=V3zI/b+v4diaS6f7zwpmIVNVuSS7083jcSL+QoNR0EVDkk9E9j/gHejDN9u0DsYxN/5o9HBv6UWItg+kX+gQ0vUXDqyMe7ni6N2sBHCZwJefBrblGJCboY/HJgDdiqbNMADU2BVHMdbTIfN0lqZSfdwIyv3Pb1+F/YGV4qJOuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105275; c=relaxed/simple;
	bh=X/CMxu+Wcc1BLZ6yTXXEuwdplxLvqklxHi3I0HvZ1sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifM5YhghJ0ESVQ9T7nOORsUmH3F76dWjD8YKCtkEzlbOVLPscVamJH6U8iRsoAxVrusoD/b2MfAsecJ9Q8qhxfJVQjFJXc/fKiVWcGTPvrt9iB2EJ74eSRSVJeUon6Z1ud6qreQ24kW+t1Y+dyJk39741uAHk/Kvg9+H0hl2C/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrRB0sKc; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrRB0sKc"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so291025ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753105273; x=1753710073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/CMxu+Wcc1BLZ6yTXXEuwdplxLvqklxHi3I0HvZ1sc=;
        b=wrRB0sKcLt8ItuXNGEuBC4QUphJS4jnezVcosHeEGddWYOgiFYpJ6KawlZ8YT70xWU
         CPViz5NSK3ZBtupsi8FvTw9+TqsxEOkls0KKzxrFYBVvvj03gl+DJRO6rKinT+qlJ8+n
         3V3IAkqRrlZbQJal1I/+4tNxGoDL0MCS3EMHScMABix0MawjkzBaTwz5NqvruGC04ZEc
         QFA/Uf6GmYWuiZQIEd+6Kr6Cci7R50DKiZmtgV85zXjFoAqMVKcunXIj/R9UIbMziFQ9
         9KK3Rw3aOz0oVen8pwOb6A4IWp/3MtZD1rJldRhnrAS5RRW/EZxVH1+EhZiX8W8mkpps
         56TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753105273; x=1753710073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/CMxu+Wcc1BLZ6yTXXEuwdplxLvqklxHi3I0HvZ1sc=;
        b=BOOGxa45XPNpsj2tcV+gBpnz0OfOA5PowyOYbNRabjiUZbjurSMEXuv4V/KO893AZZ
         NbzI8PwRbTkyyEKAZ5ZafkvxUs8iUOKgDtUrXlBq+Y8EMLCDjJ942B8VChQBAgitouGO
         Pqbb8PnuXxd9IAsUJWGPBJfAQBglPsC37SzCOT0ddMpsBX8gVjEVnHPAFidUaKvz18Af
         +cnTU7v2dCOFwLJHmUSz7LghaMyYBuHMj983kR4ZwIyG9RotNZLY2KtY+zgl101vKp1W
         U4cKRtabJOVBLDTZeggrEitSVk1FTW97HxiAduUs5Q+B8dMIGOr2B6tm9qivP4d4i/N7
         2N9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0wMP/o1l9tu1r4AYBqW/wjKPwbug1nN0tiYc6tIgRicX1U3b78/6fnqTNUAymN221TheioB0HlWlOsC6ZP1pg@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYl0ibYe08NnQZ+2t3ZHUKXxhZ8NxLLDgxGoX+XOpEcivfqAF
	zkiClA2xJxtVTUrBeDbvJzsxO6AkgfM8oZPk0iG9vqv/51WxV7l6sOiFP+aICuDQGAjXgPRHC4T
	N5KFqzZzQ65mSomUf0ELr5sGtNp2RJae947NiielG
X-Gm-Gg: ASbGncvLVUIxo1CL4SgvTy/GoJsLirj0G5CQNmLMR9AaUT5+N1jsxLlyClqSuKrFo6W
	rp7wyjs6QKUM7sPV/v9JBTWWqzFq64TsFa2rqDRmsKdS4RS/F2SIQuANu89IUo9i5Imlr2AXteQ
	SO5LEi2YqqWVHZoHl/+c0fWFow1hxVlRPTKIKtiiZt+xo3cWEeQimLYI2DmtSJBhHZtvg2MCWvD
	YDRJset
X-Google-Smtp-Source: AGHT+IHV83LP0tfjFwhzfm+LStb9AHAjPM8BS0BOqo7MAWn3Qp4XExy+AH9x4hJvY+P5EHS3w8P7pBTIRquISuawbZ4=
X-Received: by 2002:a05:6e02:3c8a:b0:3e0:58e6:d8a3 with SMTP id
 e9e14a558f8ab-3e2a18446a6mr5536615ab.27.1753105272688; Mon, 21 Jul 2025
 06:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-12-irogers@google.com>
 <inu4jmw3jpnbhpaqjou27sn7m5zlzu3ksiuhir42wz4yxj2nvz@xpekkgpqldo7>
In-Reply-To: <inu4jmw3jpnbhpaqjou27sn7m5zlzu3ksiuhir42wz4yxj2nvz@xpekkgpqldo7>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Jul 2025 06:41:00 -0700
X-Gm-Features: Ac12FXwC2QRBmn2fy99vXH91ei2LVIiaugmsdPaTLby6WW6k-lmNtGPaGk-2Xf0
Message-ID: <CAP-5=fWKKtETkDX48KomxZZa4YiRwhOr5oAOHxkb=a3i5rTmyg@mail.gmail.com>
Subject: Re: [PATCH v7 11/16] perf ilist: Add new python ilist command
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 12:32=E2=80=AFAM Gautam Menghani <gautam@linux.ibm.=
com> wrote:
>
> Hi Ian,
>
> Thanks for this. I tested this on both x86 and IBM pseries machine, the
> entire series LGTM
>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>

Many thanks,
Ian
