Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F44406270
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479446; cv=pass; b=TiYwf5GcUR3wkxrCvkrnm0uF47DJmqULWwDFSoplgK5arXVWg0T3JnxdsEuQXaI9ASsbFjqi7Mmo3nDghDfKTfeXKM0k7hPcpkzz5N6oqeyzDR/YpCX6+7uzk7WPLaKyf0wOxyXWevJN6qI2jyz91FTQhE6e5QdV/xAZiZyzGxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479446; c=relaxed/simple;
	bh=UHtXGVb1LYNhm/1CYil82b9vZfxR7lKRnarL/bAjIRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMy/TFDb+bDmp9aWoKlQfOKEYJK0QM5HgaSwtDZDIk8uIZBT/LI0RkaFJpRxyuRK3vFylRMdLqPYSiclceIp0TfGewkds2v8P3g4DOxbNH/oAw5s25lbCyZPKnIOEjjJ5S5XasUEs2btOTKa2ST/8jIihNlkskVj9ix5RS4lurc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIS6eA5Q; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIS6eA5Q"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso105735ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 09:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479443; cv=none;
        d=google.com; s=arc-20240605;
        b=A+Jjj3hoaDj1rJX1nzP6rSJ7jlxaiBfA7+v5I0+5pQO2/YGbTSQDvRWUAhnc7NWyvk
         42MfHPyBEaSYh4gI9OYcskYAB0awk9Lqfwmf/4IIsgfQY6Ofi3vuMSgnUlQ71mz+L4oL
         /acakoaFoSRafI8qPjWdese8Vqld1XTqnjI/ic9Q3dAD+nhR4u04CWsdFhqPORLjVfPJ
         TMJX0A62R9La96mZ0KfFMgcLI47nFOy8FZwKpiGHkJ7+SuIEDbMOfc6SVxgcVvJJh9Q0
         n4sKyEnQhPcC1A+mZraLE0RGMBgELU4yF5RsErxKJ55AHiOqf5fsfKUP7hhg75HqIMeg
         Fu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqvRechJO7wAMrY3N92JJRHYmvgDCMeHhLdJTb1GR0c=;
        fh=5xc+RJc3C43+W8mhCQkPDhnG+JBEx4z/qEv4HCovpp4=;
        b=hZGWKU9HZzr2WCPGMvwvIznogjKbifjwznlbJrFfXycu83aL4bg1HXd/HXPGK+QYl1
         IBmu/Z4Obfp5TIsftlg8jB+pSSMFmE3fgDCOaDgb5BVBApNIvTdaGReIpuxQ/Xuqs7DU
         5m3cH/aHnEQBjeMFnkmv8A66K5Iz/VmpwQmorcg9iMvnELkz+tv5t5dtPdJ6dsHGbBQK
         Gstvpbh9gGbs3didKxqhCBcyJkmHCIy+DDm0RUqNT1QUR00IdxRHdevf9OOMOm1tvvmV
         1RwPb9WVKExQVXKuEI2zEeT2Uxut+hvL6Xa1YicgCjTOXdTPcY5SDgKBoZC0Y3njOkIN
         W1KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777479443; x=1778084243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqvRechJO7wAMrY3N92JJRHYmvgDCMeHhLdJTb1GR0c=;
        b=wIS6eA5QY9ex9quNgfSCnor1X5H6UWgCCZEv717ZhVBVuJror5HYNrdFdEHuYDzQ5S
         yjkYKQBqH4PX4jibLXZUenhtH9f3G6BYAJJq3Wb+6qUDE0paz/l6r0ZsHRiWRHzyKuS+
         07r7PMjQX7nG4MFoAKGudetshDxzipaQC2p8frRKtHdiM/9bLs+sxsLFaRw4gwzzhW8K
         8Id4cv8FDd4NCVjRipm3obWGsrshTg/xUQ6mA+mYa9uGAj5qjW3AnZmifhSWFZkrRQJ3
         z8+YizOYcc5skb0ZhcS9jfOXFzs0fEIQZ3wMqKpmPQ+43nMtlBEwtA+BqJw6hRjalO+r
         0Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479443; x=1778084243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqvRechJO7wAMrY3N92JJRHYmvgDCMeHhLdJTb1GR0c=;
        b=lUuP0bH/AkjXlrJSgV3dLQXbboV4ycY5s0QYBWoY+6c4Mo9Qnl3kSDXDFC/Lrc5wcf
         NmzGg0PxeJQh8XrHojje3I7SJvctXi6Fqc7jD3pWKEGZEC+RMgOIlWMx7UV023w1V4qV
         U5PMgAnDfOZvhrjb3HaUUlSVjdg21URP/AFftwnIVa9d+ga0HtBy+UBCjK4WEOV9V+bt
         x4Hb5cI9a6y6CAglf3VPuPhaSMjr9vCvViYegk8T2K+TdrBNHubQfsKiqGyLucN55etL
         SlAxGmHMMOCu1Hxsq3ZnqGEcPNFdqSXWxSYZQxqHgiVjDfaYgkkvk/avUyXklg7/nfNv
         FNmg==
X-Forwarded-Encrypted: i=1; AFNElJ9UrjbDw51IussxnDu3bdqixzOtW/p4ti23HU47oa4mcFOn9CpG+0JMEPRMcyqgL9G5xR04ezM/sOz3/cHp/AVM@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBaTd9NLk7omkTff9UhesE5jzZl2lO/b1PaAyUL8f3I52kN9J
	trf1JwqHrWM30FR0RoK5t5w0qXT3xquXTBsJy+ZhZcwSGIo6lzCzUiB15MXDDzW+/fN7VYCi8+7
	4gfTXof3Iq5RoRK2KyKfPwQe7ZJFSzdM2cWBTDkhS
X-Gm-Gg: AeBDiesmvWZOT8OGxZ5UEDafMgq/Am5mkH2H3khLYk4B3neDo35xqIpCGZxl2GdPSpP
	1FvUUs02YD/dIGon9LTlE2q52D1hpTCwPu8fJa2uJvYUylXS/yM+9PCPW/v2YsHCdFPPWxw+HgJ
	+2O7FvbNAshzlu3S9XG59t/zvvOCFBz9GFWMYgDxHwtuyJNEUaiWA28KZX70yZMApk4cjKkLoC6
	e62zChKa8Yw7KHiKBqRScOATe1pocjE7XHcnUo9pKgfrzdOXcTeuqmB1tW99iPUIJqz9fDauirb
	85KU6RhOYbKic3KtdMNBUVBuBCDxpS5VvocIMEywcj7y2i3zhMy37CDjwBJ7wu7l95nIwA==
X-Received: by 2002:a17:902:f805:b0:2a7:6c4e:5914 with SMTP id
 d9443c01a7336-2b987cec51emr3278725ad.6.1777479442468; Wed, 29 Apr 2026
 09:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
 <20260428071903.1886173-10-irogers@google.com> <afGyYi01XSNIS-A2@z2>
In-Reply-To: <afGyYi01XSNIS-A2@z2>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Apr 2026 09:17:11 -0700
X-Gm-Features: AVHnY4IXBUWE5UukN8KzmjnfIpnAFj-ObYvMRfPl-5kwE68RdMoDEeELQc51_O4
Message-ID: <CAP-5=fWBccMoChGX62hVoCbHZSaFJhcPOBYvutbha9RybkNZGQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/58] perf evlist: Add reference count
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 12:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Apr 28, 2026 at 12:18:14AM -0700, Ian Rogers wrote:
> > This a no-op for most of the perf tool. The reference count is set to
> > 1 at allocation, the put will see the 1, decrement it and perform the
> > delete. The purpose for adding the reference count is for the python
> > code. Prior to this change the python code would clone evlists, but
> > this has issues if events are opened, etc. This change adds a
> > reference count for the evlists and a later change will add it to
> > evsels. The combination is needed for the python code to operate
> > correctly (not hit asserts in the evsel clone), but the changes are
> > broken apart for the sake of smaller patches.
>
> Can we keep the existing evlist__delete() code?  IIUC most parts of the
> code don't need to worry about python.  Then do we really need to
> convert them all?  Maybe we can convert only the relevant codes.

Are you thinking of evlist__delete being something like:
```
void evlist__delete(struct evlist *evlist)
{
   assert(refcount_read(evlist__refcnt(evlist)) =3D=3D 1);
   evlist__put(evlist);
}
```
This would allow the existing delete cases to remain and minimize
churn, but it creates an opportunity for a runtime assertion failure.
I'm not sure what the codebase gains long-term from this as having
both `put` and `delete` feels like an unnecessary choice for the user.

> Also I think it's better to split evlist__put() conversion and python
> code changes.

So the existing Python code embeds an evlist inside a Python object. I
don't see a way to add the reference count and keep the embedding
without inventing a 3rd way of handling Python evlists, which would be
as complex as just using the reference counts. We could remove the
embedded evlist and use evlist__new/delete, but the code wouldn't be
functional.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Added evlist__put to pyrf_evlist__init in case init is called more
> >     than once.
> >
> >     I double-checked trace__replay() and confirmed that trace->evlist
> >     is not assigned to session->evlist in that function.
> >     trace__replay creates a new session and uses its own evlist for
> >     processing file events, leaving trace->evlist pointing to the
> >     empty list created at startup. Therefore, the
> >     evlist__put(trace->evlist) call in trace__exit() is safe and
> >     correct to avoid leaking that empty list.
> >
> > v7:
> > - Added pyrf_evlist__new to zero-initialize pevlist->evlist to fix
> >   crash on re-initialization.
