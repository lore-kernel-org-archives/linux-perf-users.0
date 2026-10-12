Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6D345CDD
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842248; cv=pass; b=d9g1eT5LJwonS6+l+aKkz8yE68fH+iyl3EQ0DmaSbOvTTODnZc8OXTB7q7fNhemr8D5NQwLef+dCjcGE8B7zIv3VWbrPepRMySfEUP3u9Awe4Vk+fmXaDtogFIc87/WZRTqAPWQdUHTGTYOPYGEwdsaeCbZyvmeuvcb1SWRVxkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842248; c=relaxed/simple;
	bh=77D6s9s+jsNDn7chkK8TqOJckNVj5ac1PYAeMd2MXCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr/GXos9lIjcaiWwBZuM7gPvUXmOFvzmoBctL+QZYd+Dbw5Rj4/1ooU/blS8XwOui5afWz7j/eiBifH1DeJY3D9HKW0ETiYlNG7/l/EfPt5hYsrZvRVJLOB7oahg1C1KJwyBeiOIzSI1rLcLTl7PdbPN6gt5RJ9rfvsnyJhNjDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXnK6SWc; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXnK6SWc"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5337fa12431so568131cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791842242; cv=none;
        d=google.com; s=arc-20260327;
        b=mS9ARy3rjB5vidtwKNar5hMIbt20+koF+Nn8GcMr7+z2JZnHEXLXkL9+TdCCetRXYa
         n9UpR3A4v9UmnNm5fW7nY7P5RFliqTBxUxq9Mm44fEvGI12SnA3eddmHMdsblcX1VgSS
         vKE1tIgPpt5zjFIBTaAdXvPL2ERDGxxXX3pVyTGgrsmYhgFlnlMcM7wcaBt2lYi3ATYy
         aOfuQvq4L4jCqO69PF5HG9fw7b70uLXCyvDhQe/a3VvLY/YwEo7L/rBWtf0Xu7jMr5Xd
         mDuo915+8N4LXQcLqHKgiv7m2vhEZ4mm0MKVHgjTV9sYI5ykCkxJxU1ny1SfQhX3TN+j
         +G4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ehQxFvZATNgrzjzCw6uWnISjlL6Y3isyt66JatobNHM=;
        fh=FJ22SMW5C+GdAo6pzsC1zeFRe+2H+nq+53N1KbY9gl4=;
        b=a71Hg81jMbw6JwImMl4DiKu8kGoSQEVEoCy/G0ac50QwpLCQFpyCTsiwf1B3U2IdYY
         vIiyRkmphqh7FXzts0pa40UhKrmUgccBD5L2bX7vEsGiDZJQ4Gk7O1PnNqi0JkIMcSE8
         IlnT8DfZOUEMy/XMfPXRMoIeXb5NXZ+Fvf6m0ETgfFB4E/NM5TzBqkDUsSiEOA7/jOfE
         4DurMSINMnUMXP1LXyWJEyFTqZVthjRST2eXn50iuNFbwVDzQetH1e4csp18JiSv2oX8
         rE6ZyKkYCA+K1svxsCgnHzgmBKB1kmE7TssWuuGcPL8JanDugBkNCiVL/uadccu2jvRL
         pe2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791842242; x=1792447042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ehQxFvZATNgrzjzCw6uWnISjlL6Y3isyt66JatobNHM=;
        b=tXnK6SWcXvRfX2cH3vug89ONbtcVDpeVLnWfBKw4OP+Jmzj3R+rZjc64Lir00bCEg/
         m85jLsVxAPOcO5HVHrfyUrgJ+ORDnGng2/AMcgUZ6/vDwsvWwXJnh5o3s+HZhtWhGsiQ
         C9lRFUvPBNxGqlnEZ4wCAqnYJ2dSEyPFzJHTnw8wNoPKqRWV/G3ACQLnw6I+9CNJQeiv
         2Xm2CFqDENP/YysNlo9Ma1elzujnEOARQyIogOpztv0vzkzMa976gVTs8er1m+wQVWlB
         8pKEc8WSo5s5APmRLpJxOZ20G2cRzFPXlXqbGc1+yml0oMgwtcOTtzmJm1bsO9eRYlDM
         ZVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842242; x=1792447042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehQxFvZATNgrzjzCw6uWnISjlL6Y3isyt66JatobNHM=;
        b=D9nkfEKja5MBB5ub6XVxMWvKgCF9s1svOyEvzHMnVmydDJNrIYUoaOIfOccYj2nOd2
         MKeBafKrKFSGi+wwJ6ZXOOkCkoElufoFEfhTGKW94FNIBx77y0vPK24QKDd5y3g9jIrZ
         9OPLSJq3T9AB/ozwsHiQr4vUXImGb54uZUBYFB6loGs9jlGRqjYtYuFntaXnumbcohw4
         wSda6XvhB08OHtAyQOlX+lOku35qu7fjSCeuJWfuH9mrIl9VYZFnuZ3xC8bL5XJrMw4V
         CUB8boJsU7D/iLLYVfQSyyRpgr9WDnTcniJ7ehZq20krv1lgVlUlNzp4Ec4XyTe5EWTl
         VMiA==
X-Forwarded-Encrypted: i=1; AKwUvBzRt9gkgSezL9/xo/ezlWZcpSDezmUbVmhsFwfJMbmJMg259H3hfJjtRoPW6XGrCbVmrXwz/LD3pp++tJT7WzID@vger.kernel.org
X-Gm-Message-State: AFq9FYIhgtfWwOa5kzYcmKv7vzL3rkke7IoAQFjDtO0W1Ab98PwhHgfv
	tswqcKhIIF0BTI+V92Q0p3pd5ub81sHtjWNcSCJH5kyPuyCJNKMv1gWo+dIm1ZmAwL0YKfKEBbN
	Ip/cc2KZOj02JsGDP7jQm93kRuPHYWq5ydYlX3fFd
X-Gm-Gg: AYBFou0MDWsxETnE95lTbvwrQ8sw68+ousP1Lo2g0KaYJQ53FOu+SbzZbaEPo6rDMMX
	sa853sVNe4hvNQKAnmWuKF//PCsKyTM+IkkkxDtxscN1IKH7VjNgJiSCExwWCToc4da5PyDGeyn
	zOB5igYcQ99fKXEpsgTb+T6cQfpt7PM56MpApfAmXwNH62ykcJqt14zxdkGCTXl8ssj0uH9bBoo
	NTOqWrgR3ScdyGuLAVHcCEeHFEeoCLdFval+lo+r1bY7CNsMri8IJLe60XVltqCpjJURHmUVrft
	lPFYkGJiQDrsKSWhLLYrhWD7sHpTWYfEfvowyRGGWGTMMl31agxgwxn3LJ0gH7B7jE1T9nbZzHI
	EqhLPhn4ysQ==
X-Received: by 2002:a05:622a:1ba0:b0:534:313:9b4e with SMTP id
 d75a77b69052e-535b321298dmr37938601cf.5.1791842241862; Mon, 12 Oct 2026
 14:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929011837.4157334-1-irogers@google.com> <20260929025345.88829-1-irogers@google.com>
 <asQoWrGYmM-lGx5G@google.com>
In-Reply-To: <asQoWrGYmM-lGx5G@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:57:09 -0700
X-Gm-Features: AclHuK_ybq9gU44rwx4KLDqmYiNpgPWTmX98N4vk2I0ttWfcqLOVXmnn0LnyrzY
Message-ID: <CAP-5=fXsJG1AvkcvKg5abGFD5sEh2hs_KAfDnTohZV5-33TV+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf test: Add per-test timeout support
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 3:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Sep 28, 2026 at 07:53:44PM -0700, Ian Rogers wrote:
> > When a test hangs in 'perf test', the entire test run hangs and makes i=
t
> > difficult to inspect output from other tests.
> >
> > Add a new TEST_TIMEOUT result category and a per-test timeout (default
> > 60 seconds, configurable via '-t'/'--timeout', with 0 to disable). When
> > '-F' ('--dont-fork') is specified, timeouts are disabled.
> >
> > To enforce the timeout:
> > - Place each forked test child into its own process group via
> >   setpgid(0, 0) in the child and setpgid(pid, pid) in the parent so any
> >   subprocesses spawned by shell or workload tests can be terminated
> >   together.
> > - Arm an ITIMER_REAL periodic timer with a SIGALRM handler (using
> >   SA_RESTART so /proc status reads in check_if_command_finished() are
> >   not interrupted by EINTR while poll()/usleep() waits still wake up).
>
> Do we really need this timer?  I think poll() already has a timeout so
> it'll wake up on every 100 msec anyway?

Agreed and that avoids async/signal issues. I will fix this in v4.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > - Check elapsed child runtimes against test_timeout in finish_test() an=
d
> >   finish_tests_parallel(), sending SIGTERM first and escalating to
> >   SIGKILL after 1 second if the child process group has not exited.
> > - Report timed out tests in red ('TIMEOUT!'), track and display them in
> >   the test summary, and emit '<error message=3D"TIMEOUT" type=3D"timeou=
t">'
> >   counted under the 'errors' attribute in JUnit XML output.
> > - Document '-t'/'--timeout' and '-F'/'--dont-fork' in perf-test.txt.
> >
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
