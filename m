Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91949363A
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628796; cv=pass; b=M+LhhGPJRO+72BCxviGAtrtB25IXgoqhZZkcaaY3qLiP/x+MPYIx+3fKk0S1PqLmYtsE3U5+Bt9AFe29JFhwbO6xirqPbiu6tGy0jK3xF6n6BRjNXSG2khRzyWuo1VSQOFbQfTct7GKvbhXeEPjTIbwlj8Q2xCSn1QpkWhL+lQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628796; c=relaxed/simple;
	bh=w2pHCeTqaGuXfYVAm3ByqERScBeaHxgRUGJ/gNSHm8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWzfObgZoiLw7arGk9V393O8HROEoHAbmWYmNxpQc1M01KVwn2EKTOYC7bxHQhe3DJW2mPWRzAafsywoFa4gVlA2aWQjxJJZ/Cv7WHDhLOzKYyu1BIwKLD6h8cCHZmBWo1eTII2onfWQnesa42BQ2AnSMe1ysDXDq+rpSmvlQ60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZZL3BjU; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZZL3BjU"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c10ed63c0so95151cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 20:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787628794; cv=none;
        d=google.com; s=arc-20260327;
        b=pW7jvQDJAnJl0NWZ0jMRxLsMS7Zo31UK6HP1ZUUHywqxd3HsocadHDgTswoPWfNrur
         VmsSTbToVHqYyLjCUBaI3FtM0zNodvBMMwTpQYXwx+d3rlfqSmhFBPRVpOZxhpU37T2Q
         Rfs8jDVkXWjvC8edgGgxV4mGEvAuzyB/SCqRY2qeU66V6z6q9WT7GxF6n68596FRxBOG
         wDvIgRYjC7JS2YjD7KzXG5M+x8l/lGwT5fgV02hkGRfo+qCtQulLSgbr2H7xpPtUFrvF
         d9In9BCGso5BAujoX9btvOMGrIJ9CKrgjR4f8gAIsVm2KIUbs7BIYus2cHx6crjOQeoJ
         /P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2pHCeTqaGuXfYVAm3ByqERScBeaHxgRUGJ/gNSHm8Y=;
        fh=7g4uZefkloFoGboAPLzehKJYqd0QdesIueTBkYN+Kdc=;
        b=bT46YjbT386K1wmflnuHJMJSqlBDFntEgKiD39hNRyF1wEY9qlU3g27rzoDTOMEGmf
         vPFQGUpGMkq5b1edo/HVsObrfOAxetlVqUklsj+mtf7H2CO5vkz6JvN54MWfg0h+c50n
         cxdmXrGaRUp4SPHHKJV6O5ZVDW451OYMiSGM65ETc90vT5xJNTGs0rG/kL4Ai4wn0wHJ
         HmgOkIuj3nSB5bnm75YIND9jh35s8wZi9Cy7Jy9LnnpAXv+x9d82wwfuIqHXUaWLMnOf
         X2DTyDSOLSnAPRsB3tJNCFYKuB+cQMtu1MYvaDpZDq5Xm/Fokiezot027R4h8zibBgTw
         8oSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787628794; x=1788233594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w2pHCeTqaGuXfYVAm3ByqERScBeaHxgRUGJ/gNSHm8Y=;
        b=fZZL3BjUto0xc47HYDYiPEROPdWOlqt7Zbx6MFFY3UOUY5IGTHsE4s+qdBpMzoV1EY
         PLbbrDbDnoN6g/MhPhV6RCQxnOT+XKZXkHLWyW/PmbJdMirkRce2Ebzk/ySFOOcSj+kw
         VuFXIAtU6U0Vvn0ds7tMZe/iIMY+P/QtFbRCPWHLpczf2CSGYyDPKjlvbQGQEDNFoG8p
         sHAzsGkTp6TU55WFI0JHFky7FZtWmPNrNpzezUqMA5Py8abGRNWb4hr9znq8wbwoMkhK
         w9NfEL9WP/S5Ligzfs/h4nv3qwhwVhFosBrV2Ry+uuprEhsIv++sqnBtZpss/VfCRpK4
         YYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787628794; x=1788233594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2pHCeTqaGuXfYVAm3ByqERScBeaHxgRUGJ/gNSHm8Y=;
        b=sn5YQEN9MI1RWys7JdYQLOs5Z+eJfOr4/NC2/fz+UenrQUXv3qVQ3VTyXDhdkumJO/
         Rzx6kHvPYRInKHhZmbDIbClaxz3TRdTACCzIOfVpNGstR4bFUkJiIgKwmwfijTcMtbXk
         nD4FSW6qeTDZRLerNfzWRctwbDcbPFPCWEtD5bOSMVuoe9Jh24dQhrKO/bYxov6T7tPl
         M44j05XQ13Wi90kBwZM5u2Da7q6lPFyd0Y1Uv55tNNkRMzaedUAbDUsH3VfV7OFgMB97
         MMsE/3vOQw6ayzixf0kVZoNtjOfxiQOkphjsjoJ4fhhVg+9xE+Wv8npIgogrDhmtNrKM
         6+tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMSBUcVpUn5nKvBYwEAp/0CF3BdSFSjQ0XhZkDIJraqkzHMW+erTb8mkHH6B+QyPP0mz+p8tM/8rIPI+/jzqbg@vger.kernel.org
X-Gm-Message-State: AFuF++kG/DGYW3WD9dKwl5xxXLMiSQ0PbBqP6hjcpeuxvHWlfmqteTJ/
	YUwEmypHCCxngRWVctgkONjHGa99z1lyjNky+XGb2TCfwxLpxzvSZ4lCWUwwLeSwD5/x0yWrwX/
	jVM+h/Xhy8M1OwwbuQf8uKsiTKNDZ8wNFVjziz6Qm
X-Gm-Gg: AR+sD13EbjuKZ2RwfGVF9DiKnL3IA4Eezwpzp6tsh4ktDbBSh+CyoLJfSALxJ8oau6Z
	rO2EnJj/L5H+Ag4AlskYhHBrH7enpHOnqEkpROgFtJwDbGpsQN4bHKrsxIUdI773rAGtZVr5xh2
	x49EGvzOchEOxix4BQbayz2W6A1nTH6UTWcs8fW808DLMcQVab9vY5TrGc8fHNSstHAPL7JwQvu
	7q+ex+9g9b/ALpdksgF2FP6udI3ZVr0S0uESZhsvMW7cEdtu0q8GBdw1cOHa3kCCYbNQMvWyzkL
	y6C596mihR5IwKGtkf4wDWXnUhbfvFDagS6PINi6BBZnIw==
X-Received: by 2002:a05:622a:1ccf:b0:52d:7a3c:8396 with SMTP id
 d75a77b69052e-52e304f36ffmr6832601cf.2.1787628793760; Mon, 24 Aug 2026
 20:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-5-irogers@google.com> <aozIZLYvv78jX-3u@firstfloor.org>
In-Reply-To: <aozIZLYvv78jX-3u@firstfloor.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Aug 2026 20:33:02 -0700
X-Gm-Features: AcwNN1VMBXrFwc14fddubko2V1ctoDYhLX9jCDO6stAdtQ0a1XjNvpj-pHgXdsI
Message-ID: <CAP-5=fU25BLS9bpShaY=akjK1nURV0PXw54KNqefYhKUvi6DSg@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] perf tools: Expose opt-in --hybrid-merge
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 3:40=E2=80=AFPM Andi Kleen <andi@firstfloor.org> wr=
ote:
>
> On Sun, Aug 23, 2026 at 11:37:41PM -0700, Ian Rogers wrote:
> > Add --hybrid-merge flag to explicitly trigger event merging
> > non-interactively
> > for both perf-top and perf-report.
>
> Well it should be default on.
>
> I don't want another option I have to always specify like
> --no-children.

I agree we should be able to change defaults. Just over 2 years ago, I sent=
 out:
https://lore.kernel.org/linux-perf-users/20240516222159.3710131-1-irogers@g=
oogle.com/
That switches the histogram behavior in perf top to zero after every
refresh rather than decaying the values. If you filter perf top by
user, it can be common to get no samples. Note that around this time,
we fixed this behavior to work really nicely by using BPF instead of
horrible /proc scanning. In the default decay mode, a symbol that ran
in the past will appear in perf top even if the process with that
symbol has terminated. This happens frequently in user mode, resulting
in many ghost symbols and lingering processes. The zero mode, which
ironically matches top's behavior, isn't the default because it would
be a noticeable change in the defaults.

Anyway, this is a long winded way of saying that Namhyung and Arnaldo
pick the defaults. I didn't choose to change the defaults in this
series because I think if you test the changes, you'll see that
hitting 'M' at startup really isn't that much of a chore and it gives
a clear signal that you are doing something special. Perf top also
hints at the 'M' key along the bottom of the screen when hybrid events
are present. If this is too much to live with, I think we could make
it a config file value. I think this matches the principle of least
surprise, while the decay mode default, I'd argue, is the opposite.

Thanks,
Ian

> -Andi
