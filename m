Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCF817
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295282; cv=none; b=gUxc7NUL80bdebabDFhThp1deIh/UrYOI5JOhs0u8DnVmq1lyv+5bTyNlAPy2XkKWrEpn3aBGS9yt446yibkatVfJy9vSWn3eFZQujaNHyMWG0NgGPwGMdGE4WZPEhNfGRkXdtj/lDX5Ny+4oGwiwwyQC1JpBK9+ei+5qhEDXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295282; c=relaxed/simple;
	bh=dVc/3Jn2Xe1eFoou6kKLBzreCwKjNOyYVIoqVQpxo5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyGbhoTrIqDYcpy5emzYr64E+owyuWqo+8dxQ3tWm63Kar3/VSISTOmQpn+zIByGn9ORIDNoSM1qvzE9a7QTljngPah4FKVk7odvD0e0yLVwHbS3NncX/KHJf4w4VRMMBTNr6HlTLn8he0FsIDP4BMfHmsYWNrXJqhHyVUjGWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0HyyYn/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0HyyYn/"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so48825ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729295280; x=1729900080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVc/3Jn2Xe1eFoou6kKLBzreCwKjNOyYVIoqVQpxo5c=;
        b=y0HyyYn/kJ9JhLF7zVzsId202ehGoPJztgoSfIS4pgBQxyh3vWsl7uy4qgcLOCOsC2
         f6wtRT8LsKlC3w1X2rIM+pVlmKu/2JXLDn8c+scO3cjp6gOUaJ+QvXYZZyVJmyAHJo2W
         Ebqe5pDz7vV3CKM6HaEqpftC6SKAScfMWTFDIjPPXjFqXRCDyStrnopMAZa3kZuc9LsH
         qQ4v5WYsBkgJfzZrgjc5QrbWQt+sJV+rhHEy2Z4ohMBfgMYUFVeFUmT0+mLUfzBze2gw
         QwFAAp/eFCuwd8pCbMdcE0Vg6WvPmfjdUEoSVTh8K4I+C3n0BksE3HJI1i5n2oRJST7E
         Aqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729295280; x=1729900080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVc/3Jn2Xe1eFoou6kKLBzreCwKjNOyYVIoqVQpxo5c=;
        b=hutKh6jtuv47XvQOKydPmBAos61ME3k+72i39dJZVBugVkXqQRWSvEu0Ph/OlbXsql
         WEmkdevObrrWWbGW0dTc4qEvw8N+wvdB3ZLxtqgdVnCpZmtXkaVbSGFK9XtQ05dX3m6R
         HHG1UiiCYwQcPuA90pMMjTar6pcJADCE0lKnXZqRK54yci5uMuzFiMbOCt4znrWkomE3
         p86dgCydsUnaM4UT04TIEaG6fW5XfsXZeOIJjVjO4AxoSAwOAXySUfETakWcjEunp8eh
         IfhjeBUbpPOEBBmM6HsGep+klSxgsG4OXD/YAhe1AQYLqwIcUSjasqkzcaeU7NizZKkb
         L8jA==
X-Forwarded-Encrypted: i=1; AJvYcCUcab2DDotvwbWk8bktj+MitxnKiURESDGsc/wL7udqQJYOqyTHuJt/h+svlt/rXo+AAlohKc0eLsl+srym+hwc@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkVO3drSGyu5YJE9r410DoJuRjP9gZpw2vkcLepw4Y6oSXULB
	0OFshH3KvAvdMBVHRWEhVjs3cQK/JtDKcjS6VlkoiD1mw4VhGEvON/IYA4+GymbAq/6L5ZZzfoe
	tv84LoFPEvHANVC29gDOiWgD8rs553GeE6Ppl
X-Google-Smtp-Source: AGHT+IHX4JpuxwpzRf8AmHn/r5FS2o5FM8RjzTAqlhbkH31+MBZNx3rOdXPwqb4uojc4bFjOMCC8sp1FcGILYmAff+Y=
X-Received: by 2002:a05:6e02:3b0a:b0:3a0:9f85:d768 with SMTP id
 e9e14a558f8ab-3a3fa3bbf1dmr600655ab.11.1729295279607; Fri, 18 Oct 2024
 16:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat> <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
In-Reply-To: <Zw8cN9daNBvCJd3u@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Oct 2024 16:47:46 -0700
Message-ID: <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Namhyung Kim <namhyung@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Yunseong Kim <yskelg@gmail.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello Konstantin,
>
> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
> > On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
> > > > Yunseong created:
> > > > https://perfwiki.github.io/main/
> > > > Perhaps the solution here is to make perf.wiki.kernel.org a redirec=
t
> > > > to https://perfwiki.github.io/main/
> >
> > To speed things along, and since the old perf wiki was near-unusable an=
yway,
> > I went ahead and set the redirects from perf.wiki.kernel.org to
> > perfwiki.github.io.
> >
> > Please feel free to follow up if we need to revisit this, but things lo=
ok good
> > to me with this change.
>
> Thanks for your work, it looks good to me too.

Thanks Konstantin and Yunseong, I think it looks good!
I think the pages need some improving, there are empty pages and
things that look abandoned, such as the white paper linked from the
side bar:
https://perfwiki.github.io/main/white-paper/
I pushed a few improvements to the glossary and useful links. It
should be as easy as creating a pull request for others to contribute,
so I look forward to this.

Thanks,
Ian
