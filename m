Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263029402
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926433; cv=none; b=uMN7UDHB2zcUoAMyo3xUcOlPZ+/DhpexQAZZKBqgFZxIJeG2zDJ3NJCYsLFaT4FTAqzAqrkiIb8G0nTYu6NdJ4cfNSlqe4bjPUE0zG8BxtKq0Rz9QKqkQ1LwRvjoQSWB6f7VRpahrzdrIC7vQpvrvG6M8+yChDI4uV1EuAn/kVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926433; c=relaxed/simple;
	bh=8YWp68qxwuKrMQMapx0pKX2xFIRrKqbrwhPkeTh8yQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enREGNtX851CMDfP7jDxe1w0Okz1OesMcWpgF+Hi6NUNOhbRJMTT1HzxCAqQHoXYTfr59aD16UAzXKkmZDLp0Zm9MK8JitxnCsg8h2JEKi5luNlNd3qjvFmS1+MZt7C67zCqtYIGHPlyVyOM9Z/8kj8btuWWsZAQDeDfvhjCExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J37Hdb9v; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J37Hdb9v"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a034697fbso81011a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716926429; x=1717531229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEtRoS1f3BiXfOOkD6/RyfWg8b94KE276J+eEUHXYvQ=;
        b=J37Hdb9vDfSzYhvnCzXFdzWABye42E5RFFlKfDDy7cYJ9E6GfGfutkBvaOu0qEL84E
         SVmlCdFcCOLAwnJunDlkNRdqoU51BiFUPoE0ZHVGJT2KSV5TDcXjyjg15/qn83TVcpml
         0CSalwAEYJcjrhI+IvtJ9GiY6rCoEnaWmKsAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716926429; x=1717531229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEtRoS1f3BiXfOOkD6/RyfWg8b94KE276J+eEUHXYvQ=;
        b=tExTY2psEoTNcAbga22+IGW5yanm7g4Avb+U4AmowEdOmCpK3gJZQ8kchgSxCU/Tu8
         vMABzWE85qnU5ziut+tmX+foQ7paAFiADNXIruvRz7q6dF9wF1TCvlCo4EwVGNvYQJgg
         oK1veWQ58s4JWqXXmUB1j3LBv6TSclCNGg2PNAOOJCIf63U+pKHWKpDXBC3QD3VKrpIf
         HnYlfyWQVOyGRNkglVouqCAxt9Bv0H+QKb0f0DCQ6TSlqjwOvLCQEcE/JufuE5oUhG99
         EdNHGmG0lIGbXdk8xwt/ydgO916FkV1qh8StZ8OXzpdMtIhXKxa3TdEbqHEREkXXRm1Y
         xUwA==
X-Forwarded-Encrypted: i=1; AJvYcCXaqdAgPHPkvP/PYjSBWMDfUOOl0nKfspvB1zpUcHtdwkGvQ+BVCETyxMoIeyo9PGFMHTXlYv/7BywpVbtVNA505QWgmZpBpBBYsVYSC4bLEg==
X-Gm-Message-State: AOJu0Yw0ahYtRKx5tElbzGBWDxQIbzYsgsXj4uswsL5DpSrGSjb8qYYu
	8DeO80AMCeZrcLrzS5pr8DNRt121ZcAb+fJo3ATJrAYSH/1ALYs6hEl79AusJCGyGlZH9FZYlI/
	w18zSJA==
X-Google-Smtp-Source: AGHT+IEUdMoSwN6N7Jx6YnYfys8M8tZxW9bc4FzpOjO3B5llhqy38YtYloqUfOSZDtg8IRLLqsJLjQ==
X-Received: by 2002:a50:f605:0:b0:578:5d83:baf1 with SMTP id 4fb4d7f45d1cf-5785d83bfc2mr7559033a12.2.1716926429642;
        Tue, 28 May 2024 13:00:29 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240d1f9sm7613550a12.51.2024.05.28.13.00.29
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:00:29 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso125383366b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 13:00:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDOFbZtPLBW2HJGwS0WqsMnlFI/xE37WI1Xv/UuehxG0JRdmwdNcakPPdv1zxJotkudzjfaccsYbkqBaU3mbmE1OwqM3ebIsTqbJ7LGWz9wA==
X-Received: by 2002:a17:906:c088:b0:a59:db0f:6bd7 with SMTP id
 a640c23a62f3a-a6265116365mr793210666b.71.1716926428911; Tue, 28 May 2024
 13:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
In-Reply-To: <ZlY0F_lmB37g10OK@x1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 13:00:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3TciVzg7To1KVueCmwJoDEZZSurGPb+a7Dn7Dij=4YQ@mail.gmail.com>
Message-ID: <CAHk-=wg3TciVzg7To1KVueCmwJoDEZZSurGPb+a7Dn7Dij=4YQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 12:44, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> For 'perf record' we're asking for sampling, if the event has the name
> specified and can't be sampled, skip it, warn the user and even so
> only if verbose mode is asked, something like:

Yes. I think that's the right rule in general.

However, the more I have looked at this case, the more I am also
convinced that "cycles" as a name is special.

It's literally documented to be an alias for cpu-cycles, both in
examples and in "perf list" output, and that's what the usage is.

So even if you were to have some other PMU in the system that had a
"cycles" thing, if it's not a core event but some other cycles
("uncore", bus cycles, bicycles, whatever), it shouldn't be used even
if it could be used for profiling.

You'd have to use the full PMU name and actually list it out if you
want to use a non-core counter named "cycles".

And yes, we even have some documentation that says exactly that:

  "e.g usage::

        perf stat -a -e arm_dsu_0/cycles/"

So this isn't even anything new or ambiguous. This is just how things
*ARE*, and absolutely have to be.

                 Linus
