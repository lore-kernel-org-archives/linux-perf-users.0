Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70A4C80
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665236; cv=none; b=Te5u0W4ekfBsgs6sexJJfJu9JVlv36QZUUh/izoS9FCvVlU5MLi7qHOqRkhBk1UOg1r8C3T3JSZG0EYJK3ZYKGMM802vhGBTCh9kwP2WX9G3lgbI5TaY+x4KzR2bti5PDk0J3yESHBcBKx6Y+9naGeIwxkJFcm5gfcSUICToet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665236; c=relaxed/simple;
	bh=xuWjEFle0dQBWaWrHdHz6iXg5CQrNte1Zysakt2gVd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwoB/d8FYfgUpwAqqg0nOvT/+evd1HX9AWYC6lnZWsHtmIb38jnR4JRNTBDytBl1j4vSWTKF6Ug5Tu4Tk96xgm1yNkxDlHjnwMWvwyIMm6F7NeRrSmI/puzFDLl/GQ11GSnuJ6pyM64JH+pwlSWc6mf8OR7UgesniRrDZ2n5/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGcflw3p; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGcflw3p"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-363961cfbe2so35045ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 17:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706665234; x=1707270034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgfiRGByYS+pq3G6aWPgh8zg9GUqK9qq/oEIcJCDY4M=;
        b=MGcflw3pMQM5ZQStMzqMEWLOI34ZJ/0uF6comsDt7uhBpSdJ95w2/ezN8F4cKA60C0
         XwaczbPjLjps1DVUHAUjWBKlhfsMyijM5bbKG1sWaYf1jYVi/FRJo0ID1XesLTqExCKH
         Ttzo/Plq3MNl0pZ8HqnfQTs8SYpgF77lcT9U7LYgI7zhMpri8fZkJoXGNP+d1HZ7k3Sm
         iHnsHE7F8/gauzbkEJ898iu7lY/nyrd7XnI6lWp1K6hFvmImqdF1KbFFyaFRK69XBLVm
         G7sxYkJxzuUbv2/X4ufLF72awrSlJSAxYWfBhCsZwBH9Yc283Dsl3RySR80oGl5tvLV8
         DwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706665234; x=1707270034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgfiRGByYS+pq3G6aWPgh8zg9GUqK9qq/oEIcJCDY4M=;
        b=Q1+KevYlQ1sV6mZSwjzkrwbJEU/N7/8vC+gI/WZO5KUkEPFC2rsevRMy8Uqs8KI4U6
         M2/ELSFRrOk6AA6ZMZXFjIT042UUrpet2ceDsoXqP+i80F0VtlRNcDU68j14PSgFKy9M
         kJA2VXzfz+RFawzNyG4gLoONZc9V5jCwnizSGyn9v7j27lnjyFp9YoQaI+TWfdARA2oT
         4ggF5877RwuX2qIQ+iGuzByCcMUhcUgImGs1TKFpDlbxw1LNk6Clbksl55sutBHbh7ov
         U7fedBhb6rRYX/ZHxxWx+9mxeUhr9CPPWSHxRdvIYDNca2Gpv8E3Kc0tkbHUUXe7pNBS
         5Ytw==
X-Gm-Message-State: AOJu0YxXSeq+EbWDBDmoreV1WUw7aV+DMZTu5vxZ6n/nh4X+CBqrdY3P
	c3/dKnW+ezeZpEk+YluODAa11WQpwVTrTo73mMc43GGADoQV7UHN+Y1r3uVawj0MmJjrD+wf+qb
	i/EMgKcq+EL1hHmr6ksldLuIeGzxf207u6DRN
X-Google-Smtp-Source: AGHT+IH1Us8QLQolRkQ0N6URcVjvh46AhLYNl3OWINT5TlS9BM3Rpn7wbE5OUp/UmPI8GqmfwsP/5hFJFf9VhMmRANw=
X-Received: by 2002:a05:6e02:510:b0:363:7b1b:fc44 with SMTP id
 d16-20020a056e02051000b003637b1bfc44mr447318ils.14.1706665233872; Tue, 30 Jan
 2024 17:40:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.LRH.2.20.2401300733310.11354@Diego> <596f6329-1619-4fec-8fde-f97a3e3169b5@linux.intel.com>
In-Reply-To: <596f6329-1619-4fec-8fde-f97a3e3169b5@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jan 2024 17:40:22 -0800
Message-ID: <CAP-5=fWs+dGuC4CNvAG6hsO=MhSYHGJje1JizO-aVpJ+PkpoMA@mail.gmail.com>
Subject: Re: Intel Sapphire Rapids uncore: umask too big
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>, vmolnaro@redhat.com, edward.baker@intel.com, 
	perry.taylor@intel.com, samantha.alt@intel.com, weilin.wang@intel.com, 
	acme@kernel.org, alexander.shishkin@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 6:13=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-01-30 3:11 a.m., Michael Petlan wrote:
> > Hello Ian and others,
> >
> > we have encountered some issues with uncore events on Sapphire Rapids. =
There are
> > a couple types of problems. One of them is the following:
> >
> >     # perf stat -e uncore_cha_55/event=3D0x35,umask=3D0x10c0008101/ -a =
-- ls
> >     event syntax error: '..0x35,umask=3D0x10c0008101/'
> >                                       \___ Bad event or PMU
> >
> >     Unable to find PMU or event on a PMU of 'uncore_cha_55'
> >
> >     Initial error:
> >     event syntax error: '..0x35,umask=3D0x10c0008101/'
> >                                       \___ value too big for format, ma=
ximum is 4294967295
> >     Run 'perf list' for a list of valid events
> >
> > There is a 34bit umask that can handle it, namely umask_ext2, but it is=
 not
> > used for sapphire rapids:
> >
> > uncore_snbep.c:5958:static struct attribute *spr_uncore_cha_formats_att=
r[] =3D {
> > uncore_snbep.c-5959-    &format_attr_event.attr,
> > uncore_snbep.c-5960-    &format_attr_umask_ext4.attr,
> > uncore_snbep.c-5961-    &format_attr_tid_en2.attr,
> > uncore_snbep.c-5962-    &format_attr_edge.attr,
> > uncore_snbep.c-5963-    &format_attr_inv.attr,
> > uncore_snbep.c-5964-    &format_attr_thresh8.attr,
> > uncore_snbep.c-5965-    &format_attr_filter_tid5.attr,
> > uncore_snbep.c-5966-    NULL,
> > uncore_snbep.c-5967-};
> >
> > (I see umask_ext4 there and means 32bit:
> > uncore_snbep.c:479:DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config=
:8-15,32-55");
> > )
> >
> > What is wrong? The json files specifying umask=3D0x10c0008101 for the e=
vent,
> > or the structure that should rather support umask_ext2 ?
>
> The 8-15,32-55 is from the SPR uncore spec. But apparently, there is an
> inconsistency between the event list and the spec. I will check
> internally and send a fix.
>
> >
> > There are a few more issues, I will update when analyzing them deeper.
>
> Sure, please let me know when you find something.
>
> Thanks,
> Kan
> >
> > Thanks.
> > Michael

Thanks Michael, this is a discrepancy between the PMU driver and the
json which Kan has in hand. Was this caught by the "perf all PMU test"
?
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat_all_pmu.sh?h=3Dperf-tools-next
I'll try to improve the error message :-)

Thanks,
Ian

> >
> >
