Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61B186A;
	Sat,  1 Feb 2025 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738368863; cv=none; b=oyGmH2sj4D+qVPj0HCiza8ZPNt1b6xVK0Laaq6MrmPL7AfAwR3mnpzpgCNhOICrIkIS6pwx7UzTVWC3MfA8rr9gjY7xUK16HvWOMwDcdAtN3P1po34rN8zyVHuM5Q94qK85g5/ZWAKbLVnhVxvGJfxHVp9GdgOxU8DyoKnmf3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738368863; c=relaxed/simple;
	bh=/A5SoDz7LSIXfvnEgiwZHYpu4g9JIraM8Pn1nn2qzok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbDHLaNf+6z70oA9A/lqZOGPMzlIagZBUvS74l5TTjVImq7/cLiyD2TcXWUr0DYg+HV8JHvK3Pl1GEtaZR/fFBGmhqk92VwI+JXQMXwQHYKYtChaS7e0kbfFRbzt1AdwjQJwSfOpNJD6y1DBL5ANL9lnSWMEhb2KEtr2+Ri+dwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etPLMon4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etPLMon4"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6efc58fae20so14301957b3.0;
        Fri, 31 Jan 2025 16:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738368860; x=1738973660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjt3WE0fuhhnqx66YNfrENAdfkskKj5pJFcQO4ahr+M=;
        b=etPLMon4gtzb/IDIzHJ+AtXaSma09gyl6oimw+l9hDlPz3pvTXxCr2v+M7qrhgmArN
         k89g1/qS4fLbzL4JK1tBObOBC+oATKZs9iWJ4YAoV1Q/y2XflLM6Okh5RjIH3xj9Ies9
         NtOEPhxerx2bLx9Dz3HiXiKYuPpLyUoNBMaOXaeFx5NqgVt40UZ7FZ085U+DN1l4aovC
         VeE+S2IQTgz+IKeZzcKXvnLZTCbXqLqpLGHqc3mo2KMmM8BCD9pwveu/JAD7lh9TEFBx
         QkvgjisD08LhtVwsAlXlpXRSZJM8dMk0APCMIr1V++Ere8NmZA1UdgnwnaY6LixFCN1i
         tZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738368860; x=1738973660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjt3WE0fuhhnqx66YNfrENAdfkskKj5pJFcQO4ahr+M=;
        b=RmKk2VM7L0JVKyYn0ZfqtGA3jJJJjx4anlVHJtQDei9d8Rm4QcR4CQ8pFR+G7+UNKJ
         U2DshC3rRIJEYatJLG13ixiOhuZrl5RTwbpiVxIM7BgoqIbzKsgliTkD3EwQGnvmgB/z
         Bs3NNDi8izKpBwbzrBJ6T8LeGEuXQmMDCntfHgXkAPGoO8PwKtaiaFXnlruQAtoRKhc0
         LXHk0ffNh4TDVaK/OyOPyQl0jYVn5k2g5y8QixtiDzk8hdemMrS7yhIV5Eral1d8hEs5
         UGqYogfoMK407Bs+KPHgW+Ysy+X3uie09W1NCQeyuvwnpItfSDDvAcxsm6pwk7VcJzut
         QuIA==
X-Forwarded-Encrypted: i=1; AJvYcCUVcYIm4mBoiE9AvlmRNDEOUHRqsPV/yufk+UctRagBytiXygTKfa/DDsjoIAaOIjBCE7Py9cTH1xMFRAE=@vger.kernel.org, AJvYcCUkGcJE8MGRPCuhcwT+oEElLcCr4vb7Zk0yklLEVZomoCfceKOTe6OK4PmKxFdw3dNhMdNDhspbVzg6+bbXZ17qDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/nMidXni+TNOBLwbNmMyn0k19qoxfzeyHlmUlKEVYMjoSDum
	cNi2A8xx61f8ufBaCupn/LMoASsDBpGysE/mftbDrlksSteKSVEhYKVLCtyX7JPvezPbMOfXGNy
	noOfPbSsU2B/BnIgbWM5UlhU5ut4=
X-Gm-Gg: ASbGnct1SCH8AR8vDZyoHrLhwPxnijKVNQCKu8b6vcSB7geib9W6rFFkm/D2e+5o9G+
	P3ueDVfRfA4sqcYJIiyvW/i33DN/o7UCrYoXa7++SktGQlhlQkcuCK5otYxi+W4ocHIZ1KbU=
X-Google-Smtp-Source: AGHT+IGvsMuCmPj7gT3SIglsSG2Gow5tWVFoi561kHvD/JyEd0rZtDpb3Yu/7ldMuFSbucWPedIdoTa423PPduvBNWw=
X-Received: by 2002:a05:690c:b1e:b0:6ef:aae1:ac5d with SMTP id
 00721157ae682-6f7a83f2a2bmr113306867b3.27.1738368860424; Fri, 31 Jan 2025
 16:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com> <Z2mzzytPOpjF0Hxe@x1> <Z2m8qzyLdm1BEYuF@x1>
 <CAH0uvoga29=0iF69A5uHN+nbB458LeW+WDWHNnoQV4msVm9zDQ@mail.gmail.com>
 <Z4U343yQUDF3H7qs@x1> <Z4vyvNChyXZx33xf@google.com> <CAH0uvoiRTnT-=EeK1z6BajB9RE5F=f2S4e5a5ygo8kebyKyCqw@mail.gmail.com>
 <Z5LWkMPTu6mUtdJ-@google.com>
In-Reply-To: <Z5LWkMPTu6mUtdJ-@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 31 Jan 2025 16:14:09 -0800
X-Gm-Features: AWEUYZlbEpaMTaV3W232vXZXCF18M9akyEVKSwdIEJWe4PeU17lJGsQzwys_hVo
Message-ID: <CAH0uvoit+6nhADW_d61VcaSE17Wp5DH7BtUVjQdT=kU9rMqaaA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf trace
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

Sorry for somehow missing this reply...

On Thu, Jan 23, 2025 at 3:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jan 21, 2025 at 04:19:35PM -0800, Howard Chu wrote:
> > Hello Namhyung,
> >
> > On Sat, Jan 18, 2025 at 10:28=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Mon, Jan 13, 2025 at 12:57:23PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Fri, Jan 10, 2025 at 04:52:08PM -0800, Howard Chu wrote:
> > > > > Hello Arnaldo,
> > > > >
> > > > > On Mon, Dec 23, 2024 at 11:40=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de M=
elo wrote:
> > > > > > > On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> > > > > > > > On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > > > > > > > > Changes in v4:
> > > > > > > > >  - Use if -f to check the existence of vmlinux BTF, and e=
xit if it
> > > > > > > > >    doesn't, so trace_test_string will not overwrite $err,=
 and keep
> > > > > > > > >    running the test.
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > >  - Add vmlinux BTF check, and skip the tests if it doesn'=
t exist
> > > > > > > > >
> > > > > > > > > v1, v2:
> > > > > > > > >
> > > > > > > > > The previous version of the perf trace BTF general augmen=
tation tests
> > > > > > > > > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Mel=
o
> > > > > > > > > <acme@kernel.org> for pointing this out), this version us=
es bash instead
> > > > > > > > > of POSIX shell to pass Shellcheck.
> > > > > > > > >
> > > > > > > > > This patch series also adds documentation for the new opt=
ion
> > > > > > > > > --force-btf, which is used in the tests.
> > > > > > > > >
> > > > > > > > > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-=
W6I274@x1/
> > > > > > > > >
> > > > > > > > > Howard Chu (2):
> > > > > > > > >   perf trace: Add tests for BTF general augmentation
> > > > > > > > >   perf docs: Add documentation for --force-btf option
> > > > > > > >
> > > > > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > >
> > > > > > > Thanks, applied to perf-tools-next,
> > > > > >
> > > > > > It fails when running in parallel mode, sometimes:
> > > > > >
> > > > > > 109: perf trace BTF general tests                              =
      : FAILED!
> > > > > >
> > > > > > Then:
> > > > > >
> > > > > > root@number:~# perf stat --null -r 10 perf test "BTF general"
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > > 109: perf trace BTF general tests                              =
      : FAILED!
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > > 109: perf trace BTF general tests                              =
      : FAILED!
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > > 109: perf trace BTF general tests                              =
      : Ok
> > > > > >
> > > > > >  Performance counter stats for 'perf test BTF general' (10 runs=
):
> > > > > >
> > > > > >              2.148 +- 0.293 seconds time elapsed  ( +- 13.63% )
> > > > > >
> > > > > > root@number:~#
> > > > > >
> > > > > >
> > > > > > So its not just when running in paralell, anyway, its merged, w=
e can go
> > > > > > on from what we got there.
> > > > >
> > > > > It never fails on my machine, I think the reason is my machine is=
 not
> > > > > fully-loaded. Can you please run
> > > > > ```
> > > > > perf stat --null -r 10 perf test -vv "BTF general"
> > > > > ```
> > > > > And provide the output?
> > > >
> > > > root@number:~# grep -m1 'model name' /proc/cpuinfo
> > > > model name    : Intel(R) Core(TM) i7-14700K
> > > > root@number:~#
> > > >
> > > > root@number:~# perf stat --null -r 10 perf test -vv "BTF general"
> > > > 106: perf trace BTF general tests:
> > > > --- start ---
> > > > test child forked, pid 47824
> > > > Checking if vmlinux BTF exists
> > > > Testing perf trace's string augmentation
> > > > String augmentation test failed
> > > > ---- end(-1) ----
> > > > 106: perf trace BTF general tests                                  =
  : FAILED!
> > > > 106: perf trace BTF general tests:
> > > > --- start ---
> > > > test child forked, pid 47842
> > > > Checking if vmlinux BTF exists
> > > > Testing perf trace's string augmentation
> > > > String augmentation test failed
> > > > ---- end(-1) ----
> > > > 106: perf trace BTF general tests                                  =
  : FAILED!
> > > > ...
> > >
> > > I also see the failure on not fully-loaded machines (both Intel and
> > > AMD).
> > >
> > >   $ sudo ./perf test -v BTF
> > >   --- start ---
> > >   test child forked, pid 525025
> > >   Checking if vmlinux BTF exists
> > >   Testing perf trace's string augmentation
> > >   String augmentation test failed
> > >   ---- end(-1) ----
> > >   106: perf trace BTF general tests                                  =
  : FAILED!
> > >
> > > Thanks,
> > > Namhyung
> > >
> >
> > Just wondering, did you and Arnaldo apply this patch:
> > https://lore.kernel.org/linux-perf-users/20241213023047.541218-1-howard=
chu95@gmail.com/
>
> I don't think we applied it, will add to perf-tools.
>
> >
> > This seems to solve the problem for me...
>
> But I'm not sure if it fixes the problem.  IIUC the patch fixes the
> loading problem.

Yes. However, if the machine is unable to load the BPF program, the
error message will be:

perf $ sudo ./perf test general -v
--- start ---
test child forked, pid 173990
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAIL=
ED!

Which is indistinguishable from an actual string augmentation error
that has a string mismatch...

> And for some reason, I don't see the problem any more.
> But I remember this sometimes happened in the past.

Do you mean that perf trace breaks occasionally? This sounds urgent.
Could you please provide me with your kernel version and Clang
version? Thank you very much! :)

Thanks,
Howard
>
> Thanks,
> Namhyung
>
