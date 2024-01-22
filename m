Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732C1103
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705898989; cv=none; b=HtFn7Ahy6HhL+X52uzzTX13fGByy/MjAYxS+N2NTPLMvvL4CLkCJmWw0KhrGoS6Bhrwif6bW7fEwUTGurHXRCM8P+zKtLJRIX1booP3xD+YM8ioPFid/47LhnXCV57PQrbnDTbzvhVlyPQCZlgWKidQKLchr2duaQVMHb6lzSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705898989; c=relaxed/simple;
	bh=yLG7yPelNz0hFylKd6snTxRXgVfcJXoMw9mV0G0YphY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XzobZIeujqT1NjScMqpjoqKiq3LHzLlO8XcTJlq/+9MIiq0OcaVLt7RP5voO2XBSlHS6X6Z+vNxD36PcUX/kOWew9llZk8g1320jvao+6VU4zU6NIm3TI7f+fLgOdxiSs4Vajkh8BFsJtgvtMLg5nihUsRCesvT/weWUBlVL4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4KqRjJ3y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4KqRjJ3y"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d72d240c69so139285ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Jan 2024 20:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705898987; x=1706503787; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i+D/IfDRnZAfk8hf6MmFABTz2D8eOwv4gU6plGs7o8=;
        b=4KqRjJ3y5leCLN1K231NFVZkKF79ZgGABK6Wdh5GKgC4WJE/VIPtTiDLOH490Xc1qO
         kLdcjMmtvXl8dsTtO5rZ/hn2efIxEXLdvXewIPrIb4LfuzqB+iKjA3kFmfkaHbQI0sKV
         6/SbtY1b8q/9YWwENkvjgQD02GVgT5Ga2rVoVyYKdX3Q6Hj4Rb/RaLA5O4wY8KvJ++Tj
         q/mvPanFI7hIKcXFtFTwAWjT4VZafodVs+8vuEjS3nt6SFanKjaDJNz+ZERhwvW3DDGC
         qrX4CkuNVu9GZZO1j7pWMjQMxR/4xUdeL6Wt0LVK0h5BSwiZ80fdVNCb4a1qJR7IfS7k
         nYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705898987; x=1706503787;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i+D/IfDRnZAfk8hf6MmFABTz2D8eOwv4gU6plGs7o8=;
        b=DY9nFKiTdVUX/BhMriSPyuon1kROsyuR9AlD3aI+lK8wAUKxOfC07pUZL4X3+IAyeA
         ZA7rtqO+4ey/iDdUPyNgnk3LZTCjhOjik7xDbiCfU/xkH0aN08MsalCU/MtRcSBkLJN0
         D9zth0ttW9LmEg9MwHqNIeolTNv90UdrRhpEZoxqaIrsiZ5VYtoF4/VTBvGVAEYOQV2b
         3TJNxzlSTxcIGhMgG0HqPQ1v1m7JN+6icdr1JdFIj3FurUG7ktFN7k/opDMtiwosdtiR
         M2F4v9K8hp1R8Ip9r1GRqVLETOD2hTqdLrBmnP/VFGQUgJ9DbqL6sK/5DLapHAEbdgCo
         k3sQ==
X-Gm-Message-State: AOJu0YwZx7xgUc7CSIpMDMt+EloAXhUypORCwk6U5M+pnKs7wRUZlBSv
	0VRRVJyw/NSMjHSyx0aZRn1h+n1y6o90jE8kxWMbua+OIdg+sBDxdGqv24SwplMWBV0=
X-Google-Smtp-Source: AGHT+IHaCO5lct3RsZMeBoxaH54qzpfzqa1KWrESuqR6p0MVQUEsOn8Mzx66volGVWTblQaJjaBS4xICuW75yoK0lsc=
X-Received: by 2002:a17:902:ce83:b0:1d7:4b04:108e with SMTP id
 f3-20020a170902ce8300b001d74b04108emr102444plg.15.1705898987073; Sun, 21 Jan
 2024 20:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com> <c947fa14-40ae-4736-a951-ec47738b79a3@gmail.com>
In-Reply-To: <c947fa14-40ae-4736-a951-ec47738b79a3@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 21 Jan 2024 20:49:35 -0800
Message-ID: <CAP-5=fWSfUqZ9pOCZM47af81WdV2e8Bm67e-2XAAi7_cve9FXw@mail.gmail.com>
Subject: Fwd: Google Summer of Code 2024 - Project ideas page for the Linux
 Foundation online
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Time for GSoC project ideas and if you'd like to mentor a project let us kn=
ow.

Thanks,
Ian

---------- Forwarded message ---------
From: Till Kamppeter <till.kamppeter@gmail.com>
Date: Sun, Jan 21, 2024 at 3:34=E2=80=AFPM
Subject: Re: Google Summer of Code 2024 - Project ideas page for the
Linux Foundation online

Two additional remarks:

- This year Google wants to preferably have AI/ML-related projects, so
   to raise our chances, add such projects to your project ideas lists if
   you have and mark them prominently.

- If you are using Mastodon (Fediverse), please post with hashtags
   #LinuxFoundation and #GSoC. Also if you are using a hashtag for your
   workgroup, add this information to the contacts part of your group's
   project idea page.

    Till

On 21/01/2024 19:50, Till Kamppeter wrote:
> Hi,
>
> the Linux Foundation will apply again as mentoring organization in this
> year's Google Summer of Code.
>
> Note that GSoC 2024 allows now 3 project sizes, large (350h) and medium
> (175h) as before, but now also small (90h) in addition.
>
> All the rest is as last year, especially allowance of open source
> newcomers and not only students and flexibility with the end of the
> coding period.
>
> On January 22, 2024 (tomorrow) the application period for mentoring
> organizations for the Google Summer of Code 2024 will start.
>
> To be successful, we need a rich project idea list so that we will get
> selected by Google.
>
> I have set up a page for project ideas for the Linux Foundation's
> participation in the Google Summer of Code 2024:
>
> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2024
>
> Please add your ideas to the sub-page of your work group. Also remove
> project ideas which are already done in one of the previous years or not
> needed any more and make sure that all contact info is up-to-date and
> all links are working.
>
> Make sure to not talk about "students", but about "contributors"
> instead. I have, at least partially, taken care of this when I have
> copied your sub-group pages from last year.
>
> Also make sure to remove the "**To be updated**" phrase after having
> updated your project ideas.
>
> If you have problems mail me with your project ideas and other editing
> wishes.
>
> The ideas list is in the Linux Foundation Wiki. If you want to edit and
> did not have the edit rights already from previous years, please tell me
> and I give you edit rights. I need your name and e-mail address for
> that. If you have an account at the Linux Foundation, use preferably
> that e-mail address, but having an account at the Linux Foundation is
> not required.
>
> Please also take into account that the deadline for our application as
> mentoring organization is Feb 6 and after that Google will evaluate the
> applications. So have your ideas (at least most of them, ideas can be
> posted up to the contributor application deadline) in by then to raise
> our chances to get accepted.
>
> Please also tell us if you do not want to participate any more with your
> workgroup, so that we can remove your sub-page.
>
>     Till
