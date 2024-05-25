Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8D85940
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716671687; cv=none; b=lDnpc5aLLBo1G0T5i20vqZtK/+mkJI26bz3+fWB2/7jB92shoTxQQEKeBEc2RiKHJE+xUlWcf37NcS4TICQ5k5CZc+ExhJFqjnlw12mAn/6G78O7dwuRH5fgEZ/a76luaIQLjHvQBUBaHCNj1008EHDAmItrvLIU3F3SBrvExfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716671687; c=relaxed/simple;
	bh=JMizNw8LZD+J4U0EfhBVCA61BX3XTunM8FLpavjz9OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxsbWxwi2zfBYHr13QY6F0/lt1+H76+8t4V8KmCy5+tbspe89AVUp92CWhw0SA0fP6Y8rcHZUt1Gcar2MmJMKsYA+vVBKaswmfiL2EjYUWnltHylzwHlvZ6oUgHHsmHgED48R5vbSgizWV5G2Mo1LwPAW0I4LUG/j8pdoMc4l0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DipWNYcO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DipWNYcO"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57863e2846aso1217866a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716671684; x=1717276484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NdDqgCoGhD8QyzBd5Ssu/diBB7ZMRx12p10jgxF/V2w=;
        b=DipWNYcOt+o5w+kITcYYhmEJj44yYngntzA4DPI4TGxUXnVSWlr+1hVLHt6t5jYEgY
         9dgJzCACXMqi190oGx5DHZmisqnGlGNh/5DP6/lPvTvNmggeH9HXy2spn1q+c5e2Tycz
         rcGUlPcDmXafq9hlr8rsUt0oyGpa5WVcRvWrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716671684; x=1717276484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdDqgCoGhD8QyzBd5Ssu/diBB7ZMRx12p10jgxF/V2w=;
        b=f0qOcrUBgYaX3BRp9jmS0cvbSZMdD1RvXrrZgZkaKKbvLTINXd41FF/wZ8sMGnSE8d
         5tHU1S1e0SiABPI+t5WZLhF7fQWfuvR+hsW39xTsybo17bfiBcQ6K+yTqt9dbE28qztr
         uFo0JQjbpPax9bNOGx/E/sIt/ZYSidJNPbm8LwGOrhPzCe9OCM60ro6RgwGZI8I7c9nV
         JCPd4VtUOU2RvHf0DNEK3EB5x5em8I68AXoXKO2TsQ0IvZAjFkyD1hjIq/OF9UK61Bzz
         sYVQv46wraEvcaQyjSp8C9x4afwqQtK6bVc02i8P5OcAqjDIUpe+dAMQxcz1xRW0R9ne
         GbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXOmHpCevpP+jxVGchq/1uAnHI0WhYE8498fhtarbo1DoCpBa8upvDijLrEEFHLegXqd4owKSVHkOa4FTVfYlhIdL6zIiBETP3YcnTJEP8BEw==
X-Gm-Message-State: AOJu0YyUw5yFszdPmPeetHsNFrJhcc6M/Y82JpR0pOxDB6suUe1l/SmJ
	BAGuGSKtuoybpXPC5S0E07futhb5qBsdCVB26MCJepYbJZU0fh2zN7PnlNyUw4DjUUrPvdWgT6y
	nXoy/OA==
X-Google-Smtp-Source: AGHT+IEBae9OswWGMa1/vFRAMLn+p4JuV2iALV1of3GP2qCfjx0uhyD2IlJCcu8qCOsW3KPwd/xWgA==
X-Received: by 2002:a50:8742:0:b0:570:1ea8:c50a with SMTP id 4fb4d7f45d1cf-57851901fe3mr4055999a12.6.1716671684133;
        Sat, 25 May 2024 14:14:44 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785241214dsm3555150a12.55.2024.05.25.14.14.42
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 14:14:43 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so1416177266b.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 14:14:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlDER7iz3/+CMnU7LFII7uPLk4YT0oz0zwe/RDl1Z6l3tirrlcRXYM+FMJ78OD5H3tHJMjL+1L0puccRN9r+2vKHGBYehH6tkAZg0W0xnk9g==
X-Received: by 2002:a17:906:3b0e:b0:a59:be21:3577 with SMTP id
 a640c23a62f3a-a62649be4d3mr325715366b.43.1716671682411; Sat, 25 May 2024
 14:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 14:14:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
Message-ID: <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 09:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This makes 'perf record' work for me again.

Oh, wait, no it doesn't.

It makes just the plain "perf record" without any arguments work,
which was what I was testing because I was lazy.

So now

    $ perf record sleep 1

works fine. But

    $ perf record -e cycles:pp sleep 1

is still completely broken (with or without ":p" and ":pp").

So no. That still needs to be fixed, or the whole "prefer sysfs/JSON
by default" needs to be reverted.

               Linus
