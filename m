Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195682F36;
	Sat,  5 Apr 2025 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743813264; cv=none; b=WMyYxgMAKXv5LjsTiBfYKSDWu9VtC/gbJn15B8WSFkp4FRX8ESJZZUJmmUsLrC4Qqb8+H8/02MtIV6hiPkJgyIw6cKIeMQ60rC74F8SoYRH5BFjKJz3NpmVQ4T40HYczgbAjqTyqo1vMA4CkKG/E9Mq/taQ7zb4bbIhgGlWoAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743813264; c=relaxed/simple;
	bh=B/ZwLAKVHDWZLN1BSpH4RObsOdIRC6/Zi/NLODnIi+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5ywE/4B72Gy1HOcjyOWnKez0FOcOJgkmrXLxCUnXNBOx66M3Rs10UfPVpmcqqvBf0cAT3F3JIg4IuMx3DavQLXb/PGc4JTArhD77C2/4T8evFf+Nh0qBBcU4rKJrLLeETMnHq829gm/F7rGG3BnFy7RNB7yHLoAcPK7hrSUCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypnk8H0I; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypnk8H0I"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6feb229b716so26451477b3.3;
        Fri, 04 Apr 2025 17:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743813262; x=1744418062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vM9cC/NGrRojvvJMDDud8eS5qlET0jOCaPQVrH3OSk=;
        b=Ypnk8H0IQitSzDtLct6oX91j59YFV9zMXoxgHqoQ7biP9bOZE9aCNPP9DY8HYQccAq
         sMSs5sRyTeZoSjCxDMWN8yZKo/XNP+XYGA7Hc7dP+13s97hjoIYKAi8/lXMjAv/wN+Oz
         I1U00nocllx24lx2hnz6827+arclVJBgvr3d95JDMReIP9g+ZI8Lq3pw/Huw+lnkHH2G
         TtmNRTKP6MOs2GH9mtZvn+VI1lyHO5mO6NBXfA11NvUPYEr82i9mC5TQ9YlnkwjiKqAd
         yKJKcFhghKxTVDFTEPLnuc3BM/jOx3hVjevnBhESRuEn9pvNL6pgpFAKMWZ5uHox8BCZ
         pI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743813262; x=1744418062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vM9cC/NGrRojvvJMDDud8eS5qlET0jOCaPQVrH3OSk=;
        b=kZ9A/a+op9cFo28aDOV4DCWrSXmZ42CtxY69UdqpKnQum7yl/+qH2zGV335a5u6BBU
         vPdoWMNWwovbiGQifdEH4CHbLJGkMIZxyQ2mg0ohdtrJpCwy0NkFobFidWEfBUfARmgK
         6m1jC+LHu6vsbQFimADXhE97pl44q29uYGYJqdgMzlShhils27zS3GETvRygHOeVggTj
         nu3HHTcRvNd17r0orWkKRMHy0sF037rH6zxXjMR76JHe8T0BDwTea361jVBHnLHBHhuY
         DehRToIQwBrGKRAZ4PmdZE4sU8XfG+f8QE7AsVQwV0jJ6/cp5CNsJJ4nK8fVxnrCWBzn
         Tzdw==
X-Forwarded-Encrypted: i=1; AJvYcCWnajYT/qbox10aksjid7ft1Y3nemjU7DTDxOA9owOiu46OzQS06RYb0enlWNeQYbzEqz98Y1pzkQBYvwE=@vger.kernel.org, AJvYcCXigP/zmwUAY83SHNBLLn+6hH6Bv+9PiwmVNzO6yY4f81edG8nP9IVxON8apS4YKYwkb3YAoUNXEeRMqswjIl9hpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpOuOgpb341gDMdD/Mvs5S5FRIXwpy5eQjREt2jmptEt+y9B0
	K/PC47B8D07UJUDySDDHRgOlFh/EXIJFIanCcQLBKqr5O1jdj2AOnhmsJDC7Ki8qS7q7j8f8EKv
	IFmx7ieSv9tEkZJa0eedy0laYeQE=
X-Gm-Gg: ASbGncs5LkxIFJSs0tW7ntwGKn4cZ/J1bXfZ1VqZLY0tpwKNnHer7CUQpDYN0F4EIw4
	p7O13hCoA14MLHwS8WLQtpUwmdoBDMAYVx1Zp5ksB6POXYvn9GcV22j4Jl6TXQCrJgVnRxdkWVI
	jskrjnlKDe2QQC9M59f06zCofVOIIVtjx7ruKG4w==
X-Google-Smtp-Source: AGHT+IEUB5fROKPu/BRTo2LDDb4fpCml3iuVHxzJWYMOvwrTq/vPLrg+oa2cuxcOvukL9jdPhDqzeXR03D+gGeR0pDk=
X-Received: by 2002:a05:690c:dd0:b0:6fb:9c08:4980 with SMTP id
 00721157ae682-703e1632403mr87608987b3.27.1743813261771; Fri, 04 Apr 2025
 17:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404041652.329340-1-howardchu95@gmail.com> <Z_AeswETE5xLcPT8@google.com>
In-Reply-To: <Z_AeswETE5xLcPT8@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 4 Apr 2025 17:34:11 -0700
X-Gm-Features: ATxdqUH85tTK9fhPrlOYCq-5At9ozoUFJrRKzaN8LYPxKOht6-23DElyDA418Po
Message-ID: <CAH0uvoiDqn=2ySAYfn7HsNsnu3W8zED5jFqOPTpjW++pmrbbEg@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix inconsistent failures in perf trace's tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Fri, Apr 4, 2025 at 11:02=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Apr 03, 2025 at 09:16:52PM -0700, Howard Chu wrote:
> > There are two failures that frequently occur in perf trace's tests. One
> > is the failure of 'perf trace BTF general tests'; The other one is the
> > failure of 'perf trace record and replay', which, when run independentl=
y,
> > always succeeds.
> >
> > The root cause of the first failure, is that perf trace may give two ty=
pes
> > of output, depending on whether the comm of a process can be parsed, fo=
r
> > example:
> >
> > mv/312705 renameat2(CWD, "/tmp/file1_VJOT", CWD, "/tmp/file2_VJOT", NOR=
EPLACE) =3D 0
> > :312774/312774 renameat2(CWD, "/tmp/file1_5YcE", CWD, "/tmp/file2_5YcE"=
, NOREPLACE) =3D 0
> >
> > In the test, however, grep is always looking for the comm 'mv', which
> > sometimes may not be present.
> >
> > The cause of the second failure is that 'perf trace BTF general tests'
> > modifies the perf config, and because tests are run concurrently,
> > subsequent tests use the modified perf config before the BTF general
> > test can restore the original config. Mark the BTF general tests as
> > exclusive will solve the failure.
>
> I'm not sure if the config is the cause of the failure.  Also I don't
> see it restored.

Yeah because (exclusive) got it fixed, I didn't restore the
environment variable, just deleted the config file.

>
> IIUC the export only affects child processes from the current shell.
> So other tests running in parallel won't see the config change.

I'll look into it thanks.

>
> But still, there should be something to affect the behavior.  It's
> strange to miss the task name in COMM record.
>
> I also confirm that running the test serially fixes it.

Thanks, do you want a tested-by?

Thanks,
Howard

>
> Thanks,
> Namhyung
