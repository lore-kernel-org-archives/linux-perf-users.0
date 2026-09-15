Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E9430CE3
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505590; cv=pass; b=CnAfcFPEZ7ZOYwvivODsuBo4+XeHOkvMB7vZkGu0lJUH/yJddYQMZD9ygfUE0cceHPjCN1YXNtiIpzIhkyABe+hfT7mllUZJmue/Gsi0zPoWp+9CF9ARRVZYL0qBRD8ImGOWIwtNAEzPqOlSPetIXrwy4ItTE03AfHBHTquQbgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505590; c=relaxed/simple;
	bh=Yu/GVSLVCFsCORBF+H7rzZHEtXbnIr1kuWpuj/0Q8iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3PMGiSDdBk7w/Q3kpd3boSDKK6K1vekwF8cHko5b/gChPzo3VoSVfpLG9Ur0Ry9ZrJDSOiKCkC4IpGYI92wJD19I4yoTRv47HxyJdnAPc4NDarQfB0h0vtFTwSC0kNYg+zLF6nvFFlYpUjQ6thU/LOr8RciDxIwpdeWCibuP4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULFwqaSL; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULFwqaSL"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so156033a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789505588; cv=none;
        d=google.com; s=arc-20260327;
        b=f6D6ZSVowp241jhvdrfyXj5VA6KMs8w4orGWeki1gafwkpJiEbryktTmD0VpxEuLjB
         DhLR193TPQSbbAWckrep4OQ/2n4tfIEedqWFzTPOwjBSUk3ckKYHdX6H45tF6j4KzaIl
         GYows77YMZXE5dxNlw8zKXk0//8D77QQhyvwdh5ukN/9e2z0CRkw7mlbdfwZpLS7ypVw
         X07R7SEy2gp5GT5DbqnR5rXEo6K6hO8T9bf8CNm7mr8TuozWa4DPVJSZtlGxaWMJXG8N
         a14CCCenNT5/WVj+vy6G7KBKY0kxVknwe6LuDOX09/p6YA1vHuqXxNkUAbw9c9laYvub
         0HIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6rMCIWAndgqGHUhmczP/JJpII4POFmLZaicBAR5dlJQ=;
        fh=9NkN8Gh+AQkTW1m96djOZOcHV3md+37caOPGdqLFovQ=;
        b=jSavllsnJF6NDMSDh8C+BFU1ubO9wLW4DfTitkhqQOjfjqQiVd6r8iXjNbDuVtV5/2
         kwcFkkwZM3MjAQm57HU4x92FJRe7gfIGid+JuMNkmcbUoyaAbzHM++KsziI//4ElEnLI
         rJTA43F1VW+iyH0RcW6ZHwqYvGCgcHZ8PdEPfpk87wpSGbXEfeRVKSK6jugEh1H9aGDZ
         W3dZxJz8ZliTfwoU64kFGnDiFLTB3rBIfwsmDv5ogHrbBqIF70vrSTuDewR3UMiVvvwX
         PSyFbPZYwFvh1dbTd5sKbCJta0fLR5/hgysucG9nIpjg6/M4PFdsg9Z2L27RDQYdKPku
         EQYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789505588; x=1790110388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6rMCIWAndgqGHUhmczP/JJpII4POFmLZaicBAR5dlJQ=;
        b=ULFwqaSLFxwTExBrhE5Syum4lLGfOkBY1x30ndap4RJaD7RwUSOPowqDZ12AkAnYQh
         SMTrRPzXrr+fx7d2/JTnewDqaUPY6dzW4UkY+q/t9bmKN6W2RXGloKGqyvOW5tFhXZ5S
         vLBMsYn++yjgiX5BxzdFSzKKEbT0nJxoJGGhJNE/E0Fyl4oaC5cDvj3JFQpm67s0xR/l
         RBkkcAJ+LwoPcgw4iUkM5YgFttGM6a9H4/VxI2wAaT3ryD9iDntbqSyVqnMtXunfoNwK
         /dg6/MjLB528eZqR/fyusEv6cj8y7k3Uw0oCS0NikduSg0gWNWpIqpdZzoC0H/cvbiK9
         it8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789505588; x=1790110388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6rMCIWAndgqGHUhmczP/JJpII4POFmLZaicBAR5dlJQ=;
        b=w7EGusIK4oVJ9oS3rDcPwqTTPXZ4khXlprb0KHOHs6CP8YVMEKqcSaGf10MOHGCcuV
         G8hkVk1qELHSEKZb3ROb7KqpxbVpYmzT7axMgaEWBS4kG02SletUmEOvUV+9KCAZsvj7
         7GBQZ0J16NGEfBzmN0b8ow/O9vYOPcN1osBAgGqwDU190CdB9XC5AOq4BW2JGtT93T1j
         /QcaM2dkeLzL3EARWOStEIJfZk06d7ZBnVl7hlvabXPnXumIGPbAGLazTx23GDAsERBG
         fI/n5EPKqYDM/3t1K2R0SNNvX5lOoV+x5qJCiV9tyBX862BitLymJbtWckxh2Uw9uFQi
         vzMg==
X-Forwarded-Encrypted: i=1; AKwUvByjGD7fx5U8udXRU2Eq+7xCg7Y31VAVxHNGQrFDTWKQex2U3kV5h9VmQtPsTZ6zxmnUCrQcdsyG92qNIZ3he8SK@vger.kernel.org
X-Gm-Message-State: AFuF++mpq2EUko7zxcTzxMC4srBWvXBQvrY14tzMcNMXMBXNCFrNd2VC
	iFlTlNQbbQ5mxVGJm5ER1RvmAb4kshFYQsKJJCjspWBZlwegvJ80kOJd9Qxj4+JBoJy5JfQHRum
	R8aJ83+Ef22lVW3zZ2y9FXpLYHVMacqabaChbSXEi
X-Gm-Gg: AYBFou1Qw2ECAaEkjSTaBgs1QUrgqPLr9MCVem43zGGiikIAAvc7Dx94RbKCGr1WCAK
	tRf84pN8t7qWlX2vJkQKQWsVmzXtA0s6X9IKa7PUV1HTl0UHSbllM9G8fCHc3UIF3txJFFDKNo8
	kCwf+YF0C02ZBA+6V7I1+R9yKwBYkmv9ItxmkyWr1WHFSRYg8JmlXS0EQlRTOmzrJK5sYyTl1CG
	kIpAZMsi6CzvN5JirDaRkZCzNw/UWTnyfw67CNx0vyw4JpRBidb2fXJOTEuxlhRDPO8cdWaQekq
	E1j+oFB99YbeHiXajO9BBvBZpkIuRS9mB3pkLKLPsvVXAfKgJRXZgA==
X-Received: by 2002:a17:90b:4b83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-39e1e4c4687mr170061a91.18.1789505587709; Tue, 15 Sep 2026
 13:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602181349.3969429-1-ctshao@google.com> <20260602181349.3969429-2-ctshao@google.com>
 <CAP-5=fVwLO29i5SoLjOBhPqqUMTiy-z52Wm1mbeBF_941Jbx9Q@mail.gmail.com>
 <aihLa9ezNXXZm9mC@x1> <aqdRi7v_A03mY1tU@x2> <CAJpZYjXT5rrqQuUTePV6WS5XafgtW1Z4FxMoT93uKjYdKU1VWw@mail.gmail.com>
 <CAP-5=fWKaSgVF5M-m7fObPdt5=MFZpK0RcmAS_G5thTYSzLXPw@mail.gmail.com>
In-Reply-To: <CAP-5=fWKaSgVF5M-m7fObPdt5=MFZpK0RcmAS_G5thTYSzLXPw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 15 Sep 2026 13:52:31 -0700
X-Gm-Features: AcwNN1UGrosb77A4d6cnIyDQVozvJ3caWUDEAq9vyo7WccBECoRDfyB_X69n7fw
Message-ID: <CAJpZYjVaD+axOaRLzbDe4343GNo2H3pZE7EOqNs49aubQTJuUw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] perf evsel: Find process with busy PMUs for EBUSY
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:54=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Sep 14, 2026 at 1:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > On Sun, Sep 13, 2026 at 6:44=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Jun 09, 2026 at 02:20:43PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Tue, Jun 09, 2026 at 08:58:03AM -0700, Ian Rogers wrote:
> > > > > On Tue, Jun 2, 2026 at 11:13=E2=80=AFAM Chun-Tse Shao <ctshao@goo=
gle.com> wrote:
> > > > > >
> > > > > > It parses fdinfo with PMU type, comparing with the event which =
failed to
> > > > > > open, and report the processes causing EBUSY error.
> > > > > >
> > > > > > Testing cycles and intel_pt//
> > > > > >
> > > > > >   $ ./perf stat -e cycles &
> > > > > >   [1] 55569
> > > > > >   $ ./perf stat -e intel_pt// &
> > > > > >   [2] 55683
> > > > > >   $ ./perf stat -e intel_pt//
> > > > > >   Error:
> > > > > >   The PMU intel_pt counters are busy and in use by another proc=
ess.
> > > > > >   Possible processes:
> > > > > >   55683 ./perf stat -e intel_pt//
> > > > > >
> > > > > > Only perf with intel_pt was reported.
> > > > > >
> > > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > > >
> > > > > Arnaldo, as the kernel piece of this landed (thanks Peter!) could=
 we
> > > > > land the tool part too?
> > > >
> > > > Thanks for pointing this out to me, I'll do some housekeeping and
> > > > process this.
> > >
> > > I think this hasn't landed, I tried to find the userland part of v8 b=
ut
> > > didn't manage to, can you please point it to me?
> > >
> > > - Arnaldo
> >
> > Hi Arnaldo,
> >
> > Thanks for taking care this. The link to lkml for this userland part
> > is: https://lore.kernel.org/all/20260602181349.3969429-2-ctshao@google.=
com/
>
> Hi CT,
>
> Would it be possible to rebase and resend the tool part as a v9? This
> will also trigger the Sashiko review, which would be nice to have.
>
> Thanks,
> Ian

Thank you Ian, please check
lore.kernel.org/20260915204951.2935261-2-ctshao@google.com for the
rebased v9 patch.


-CT

>
> > The kernel part
> > (https://lore.kernel.org/all/20260602181349.3969429-1-ctshao@google.com=
/)
> > was merged by Peter Zijlstra and I can see a tip-bot replied on it.
> >
> > -CT
