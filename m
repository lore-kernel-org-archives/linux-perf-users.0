Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845B33ADA0
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291106; cv=pass; b=rbR1EOk2QZC4QExmLfapA7hVsqI8NyxPbQsX+iarSrVeVVQjuDVeOthXCET2FU3f5QpFSZ/1a+ieptmzumo6l9HLG0ADGbiRoKyHzVzjYix+uw4WmrwrnaCsCwwFV4aLMK8qSFZDejHxmx0w6tegqpgJ5GGDgbCBNJ9X/Lj52uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291106; c=relaxed/simple;
	bh=t/LeLsFeqvU9pme+8GhNrpGzANUHP38OETaaGdEtI04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu1qqPj/Ypybp0renIPrxrDVl40tLs2SZXMKoTzDHdcwwICb67qtMKCB9/Cq8dP1UeGBOW2eQ/PGijqJV+ndqyilaZyLqns+Iok79hH/WQyoMCwS8QvvogJ+E4/V4KDcOzBaHjQEMl7VDzYRkZNZbHjBRyhIdg/+CZEjSk1iRVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwKt4xO7; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwKt4xO7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so785ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 08:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291104; cv=none;
        d=google.com; s=arc-20240605;
        b=LbmYdeqOMO4aKuTBlOdwdBXKAp/1QeyvWxVC3ZltQNPEeDofL8K6aSmXYphG+wk93a
         ipYaxVprFeUK3MPjrKpQOR1lqN3BJai6XQofHFChqIH2ULeC4rVfdty29xwT8zKsz/6O
         eLl1UjOSzd16q1kO9RUSURDyqh19HEBRSySEyyP2WpbVBObu5oiezgAboIURC83DBK5E
         obkUC56V5Vpe58W9g9UfR7TG279N6buCiQ3jk4ZsnEKkKzNyjWB0+1YwVUitYmZ2sQvO
         O7t4anYznHMnAI6VBRmfoTsx0sOuYI5C5B0gH79gVZDkBWbyGL8WF9KqpPMVG7lUfvV/
         2tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOsobkPKc/oq/wTpzPw1ddUlE/zH0ia7SLxEHdVAlCM=;
        fh=WGuCUoaYLSJyG0wTKzuWq93t+vrqUQRJr5kE5iYMYc0=;
        b=ZDutzDdogRJLuLP2lPUTOrd/xGymJmPL+1OyoMpkW+4I0Moy2ESO0Od94HjHc0slgx
         ZAYYhGC9b5vfF94o5BpPGS4A22k+MhGPuMGQSwr6suvqL4Oa9l9W2+stMyRsAjUJJSEp
         6mjg5D91yz1zPRH47liYHA8KJ0Pag92yn9MLMyxAdA8u8bH5hO2XVydm889OHlEpqiBj
         2q4V5OjefhhoQFQR5dr1Pc+BR8n8MDZBW0a0vN0TseEKW69TeAyJ2C+m8y1CDF6tGJgM
         17S3z1PE0765GR79Wrquk+k5ALuev4dxXeVus5C9bJiks9RP6fgN8yvZLKM5a7uhjJoa
         sNmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779291104; x=1779895904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOsobkPKc/oq/wTpzPw1ddUlE/zH0ia7SLxEHdVAlCM=;
        b=iwKt4xO73bSKar9b8TSm0C98WarPvF4LxAqZkpQlyN5fwQ7hxHauZa43xKt28UcJp5
         HmFI7vtQNnqQ9vA4roLU+kxujMDq1AMOYBSdm05IOGtyPmkjPaxrDese6bMuRWxFYZFf
         ssn9ncCBsGCGIoTMQw9vkvW+fg4zPaD8izVy7oafP3j1tooxwrh3g84zG4NImB9uoao9
         aKCCrPAzXAdDmzHhm9N0jnTVxnAMy0NHsdPcYhB+esO3I/xzmHYgcpELWgLfM0yJtE+K
         k1v3DWCEqeq/PPW86ltH1VmtbRUoSqoLkaCMcFlqfWncxvDf0NrG6gTzy4v3NBzCZx6i
         LMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291104; x=1779895904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOsobkPKc/oq/wTpzPw1ddUlE/zH0ia7SLxEHdVAlCM=;
        b=GrBIQErr7zNRuWFF3/hWKXRuDoEPerBbTi4JDESmwg1NQjAFUIW792PAxYrlBn1fxY
         myS8LjJ2cacK3zUHwqa/ky2MvTU1jQGjSA/T1he+0nDumqnNteNv++YOM+jxKjbiBzdb
         QnpXYRuzgW1OWRPQlBqUaU/ZqkZd+stQlgNjWdYh71IHQk1Dn7ZY1x2mQcgWT7Ah3W67
         oq6NX/jm0o4aUKMCIGrqYsBoIaEblXkhD6kLN1lrxnGCp9EBuSJL0XU1AwhAWc/Jcqvw
         liRzW+WsJIq7eIMBBW+PMStGzpU/Cja8Ie+zz8+Zap/RtelzVcvM6elnaTWWos6kKfPq
         aygg==
X-Forwarded-Encrypted: i=1; AFNElJ/i5h7zTlBA1z1/s7SlFFGn7phnYiKCLqubkGaRdpARiCPHH2pj43u8fr1kuL2oojg9j8tR6gBwUb2ud3elrsBh@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvi5SdkN3YNmgLZZtSghIWtuGmFhpm7L45g1rzgvkZYkAtIk0
	b6TRJ1GeGv2vCnM2EowXY+kft1z1zFYgBNji8eI8ZDUN1nDjHsTVZ5eAzc09syDjv5q0KpTq6+7
	U89tXuxJi403gaBY/6uHDotwlmFXP6G9Wlt8dPFv8
X-Gm-Gg: Acq92OE2N6wOz7aoBu0DB4PkfvXyfBe9z1QiyqMLOBJ4QXw5g1+4AKKyjD8omH4FVEH
	BiIdi+uE0JXQfGhC3dYpDkchrcKyB3H95ZzUmiMjzgF4iquMtUaUAsdOmge17pF895iy4cuDNCv
	Lr/YDDCCGv0Pz6wJ/I9ISh7f084LoWMVwpBo0O9HEa5zSv0bVv9i11HmY72HaRTHdDulB+XMtH/
	jSnQpFx+QAP1+4zOkXIuAfI7Ap1sNQ8m0vKeSs2Vc9P06AsTYpIWrZfcfUg69Eoc+cW8DX02dKS
	1y8TYpGfW5ZL1c+5avGfUL9k0/4/9r9mLniG9mdsUfhYlbfq
X-Received: by 2002:a17:903:2f03:b0:2bd:6727:d689 with SMTP id
 d9443c01a7336-2bdb03a2b85mr10761065ad.12.1779291103496; Wed, 20 May 2026
 08:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518043140.2522141-1-irogers@google.com> <20260518062904.2591616-1-irogers@google.com>
In-Reply-To: <20260518062904.2591616-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 08:31:31 -0700
X-Gm-Features: AVHnY4IeN_0JW2OSfJ0cjs0ho2uUwLsk4-alBbqIlOYk5yVrZGOot9ulb8rSWjw
Message-ID: <CAP-5=fVQ_t-kd0ZcN-GO32-SsRkO2q3QYRU76TKYYG6pqYSs1w@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] perf tests: Add uncore and x86 topdown event
 sorting tests
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com, 
	german.gomez@arm.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 11:29=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> A patch thread changing event sorting highlighted a lack of testing
> for the more complicated uncore and x86 perf metric event sorting:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfWRgDo7UnJAD4C--d=3DmVPR=
hOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com/

Purely test changes with green analysis from Sashiko:
https://sashiko.dev/#/patchset/20260518062904.2591616-1-irogers%40google.co=
m
It would be nice to get help landing this.

Thanks,
Ian

> v8: Simplify event_cb in the uncore event sorting test by removing the
>     unreachable dead-code else block (reported by Sashiko).
>
> v7: - Prevent double-free of m.event1 and dangling pointer access upon
>       PMU scanning loop termination or early continue in the uncore
>       event sorting test by utilizing standard perf zfree() helpers
>       (reported by Sashiko).
>     - Document Intel Hybrid CPU architectural invariants in the x86
>       topdown test to clarify why instructions correctly leads a group
>       of 2 on E-cores (cpu_atom) where slots is unsupported and
>       filtered out (reported by Sashiko).
>
> v6: - Ensure robust error initialization and resource cleanup in both
>       uncore and topdown tests by initializing evlist to NULL and
>       parse_events_error at function entry, preventing uninitialized
>       stack access or resource leaks on early return paths (reported
>       by Sashiko).
>     - Prevent double evaluation and duplicate debug logging upon test
>       assertion failure in the x86 topdown test by caching test_sort()
>       return values into local variables (reported by Sashiko).
>
> v5: - Strengthen uncore event sorting test assertions to require at
>       least 4 total events (>=3D 2 groups of 2 events) instead of > 0
>       events, guaranteeing that multi-PMU wildcard expansion is
>       genuinely exercised across multiple sibling PMUs (reported by Sashi=
ko).
>     - Fix memory leaks on assertion failure across both uncore and
>       topdown test suites by replacing standard TEST_ASSERT macros
>       with local CHECK macros that correctly branch to out_err cleanup
>       handlers (reported by Sashiko).
>     - Fix test_sort() in the x86 topdown test to correctly return TEST_FA=
IL (-1)
>       instead of parse_events() internal error codes (e.g., -EINVAL) when=
 event
>       parsing fails (reported by Namhyung).
>
> v4: Fix malformed event group string formatting in the uncore event
>     sorting test when running on AMD systems (where sysfs event
>     aliases lack JSON descriptions - reported by Namhyung). Added a
>     helper to strip redundant PMU prefixes and trailing slashes to
>     ensure parse_events() receives valid syntax across all
>     architectures.
>
> v3: Address sashiko nits on using evsel__name and ensuring slots is injec=
ted.
> https://lore.kernel.org/linux-perf-users/20260331185419.4085479-1-irogers=
@google.com/
>
> v2: Address indentation and other nits from Namhyung. Add Zide Chen's
>     tested-by tags.
> https://lore.kernel.org/lkml/20260331165207.4016392-1-irogers@google.com/
>
> v1: https://lore.kernel.org/lkml/20260325183045.1229502-1-irogers@google.=
com/
>
> Ian Rogers (2):
>   perf tests: Add test for uncore event sorting
>   perf arch x86 tests: Add test for topdown event sorting
>
>  tools/perf/arch/x86/tests/topdown.c     | 166 +++++++++++++++++++++-
>  tools/perf/tests/Build                  |   1 +
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/uncore-event-sorting.c | 176 ++++++++++++++++++++++++
>  5 files changed, 344 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/uncore-event-sorting.c
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
