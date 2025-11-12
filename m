Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73932C954
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967078; cv=none; b=js9BXBCejFSQy12SUK919U7kNjh6kXnXWwd8BUYfw2NVFhSanoDl2LE+u8JluTl2d7Sy6dUxIftjwx0KoUTj8JqY3TSSpNnWkeswTf+KRvTbN5PT5phwYeul19nEQKtjZqhdbEPZ/aGVpAsOWdNC3t613yyqrx/zC+RxcO7WwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967078; c=relaxed/simple;
	bh=fJ2UpAn9dwzJY1Yc747IUbNViB6Q4h6iljBno2rlX2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riJjkRe7MhngglZR/yb7DjwfVgcVd2bIpaCRpvtXkw/MKN8veW6CaNzb9oPqNzclcSG2FpNLxM/LssGZlZd9uMgFekSOwpGc74FONQVZD57UvCItNj7aAgPTrLyLEb/wtRdiqhJdel6wLLLe7RGG9yb3O9sb7EAKoZ3uDp0dna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tD69oBnI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD69oBnI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2980343d9d1so200975ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762967076; x=1763571876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTmAoxf6PxaYgcSEvKFeK7hyUGw5oXTHUHETAvMAchc=;
        b=tD69oBnI+oJOUxlWiSrz96IifgE3pVOUvLrSLQMwV3udqeYMUQYyfiA/Tks7aYUmDw
         U9dqhpovnS3f6y8ms7rYgTbLOCXcrfT2Lnt45bQN0uKkZWeG2dFMt5Yks1apnu3M2Bc2
         vz+fobRaQ0lY985CWi2NMY0zRNiemqCHY3qHtfjYmUDU/nj2f3F/trkkjrA9N2er1kzq
         VNr7LXbndB5Y4R6Nsuowpxq1RlOYFVC7w29AeQ11Pu7zWZ7F6Secp3knDJtS50YXfNLg
         TOPKpiAfn20ynJYGaol5qsihOBZNWnCGXx0iFcZeQQKBpaQM2JVbfLP+dIHCkAdmkFoY
         wyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762967076; x=1763571876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kTmAoxf6PxaYgcSEvKFeK7hyUGw5oXTHUHETAvMAchc=;
        b=Q0QMlJYQUFO6gaw4o3w+xmO4tDk8liW3ObZQ1SoX8Cch5bUPRtlmWoZ4A8u0riWcoF
         fxtRZxfqZO/ZaKREggtlXoyLAtEwX7/4F0mvIa181c8hjTZc73XrBOe6OP4xkXOwnUiJ
         SiQaqqCOi8RENPMxNZNPkSl+kVCABA4eb/uK8Fu0vl7lyKxDNRubODVY3Bd2N/wIlx0M
         X+Ljdh+fHowLP5BTtqosIKdSkJyb1IknwTZe6sp1poLUCrgHMEn8DhZPD+XkPHaxivB2
         P/7Rhnkxyj7J2jumRik2OY/ENFmDO92N2f2WJcsKz+BUEuoju8HFjLUyw4yX7W3Eb3uS
         iTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQqVxJ46S08UWvb7zBRNtWjAthLm6oIGv/f6wmcO1JmGcG3WwSF3kESiEjeYgPv6APiHZBlefmHT0l4hfsC7ye@vger.kernel.org
X-Gm-Message-State: AOJu0YyamdIZImzfuNeKPHtfbd6ZAqyY9iiEKG9uiQiObzRWBDkfD1pH
	WVOzCPhNCkeeP7MLUCdBU8bwHgbo0OQRJUdkCJFDLdZeO51XA+i5mptxalV7dh8r2P/m2I1RuDv
	7lakW4ZFXZjhtf3anPvfYw+5xgb8xZaecS4tNlymw
X-Gm-Gg: ASbGncvxfr+bffKP1PigBLKEejbGR9At8WFziJQ6yvoLJGP4r9AZGq+FBSBxlmpg2Sq
	5I+eNcBUPAVDGaAFi74/Dact2U23LyzNujis0zejG/I/tk+/FGZz9eNyQSZyzCKIQx8jR+zPL/w
	8QG5jlw2Qrv0qf+wv6U5bi/nx7OMArhuj1b/swYxhma6NfMGWxci6agG9vM6QiwC/RTEMvyCgV2
	88215jKuDSxMj2A4ztt+HDEpRJ78cGKaZBUDntxerLDbGpS9WUUjnJPHYpf3UL7RL4+FJ8ktEe3
	3BYY8vbYvRnNoa0IOQLKBbFx3w==
X-Google-Smtp-Source: AGHT+IFXzM7Jyq/bZmLxDHJHOzz00TDAilxoWOVvrPTZb7+provUty+VWoLRgHERXxVpYKhELUVxNKe2owKDR8Bihek=
X-Received: by 2002:a17:903:41d1:b0:290:d7fd:6297 with SMTP id
 d9443c01a7336-2984f7a2f70mr5997435ad.2.1762967075871; Wed, 12 Nov 2025
 09:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112164823.80168-1-zide.chen@intel.com>
In-Reply-To: <20251112164823.80168-1-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 09:04:20 -0800
X-Gm-Features: AWmQ_bkU64JSOZPD_LuedZUIfutBVM1nGmzxJZGEqecl7PeaJ94ZuGni1zqCCTw
Message-ID: <CAP-5=fXWe7TJy_28gEyzJdFnE0USAMD6jDbgkG_W2+EtO_evSg@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Add a perf event fallback test
To: Zide Chen <zide.chen@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, thomas.falcon@intel.com, 
	dapeng1.mi@linux.intel.com, xudong.hao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 8:55=E2=80=AFAM Zide Chen <zide.chen@intel.com> wro=
te:
>
> This adds test cases to verify the precise ip fallback logic:
>
> - If the system supports precise ip, for an event given with the maximum
>   precision level, it should be able to decrease precise_ip to find a
>   supported level.
> - The same fallback behavior should also work in more complex scenarios,
>   such as event groups or when PEBS is involved
>
> Additional fallback tests, such as those covering missing feature cases,
> can be added in the future.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Incorporated Namhyung's suggestion to change cycles:ppp to cycles:P
>
>  .../tests/shell/test_event_open_fallback.sh   | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_event_open_fallback.sh
>
> diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/p=
erf/tests/shell/test_event_open_fallback.sh
> new file mode 100755
> index 000000000000..9c411153c01b
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> @@ -0,0 +1,86 @@
> +#!/bin/bash
> +# Perf event open fallback test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +skip_cnt=3D0
> +ok_cnt=3D0
> +err_cnt=3D0
> +
> +cleanup()
> +{
> +       rm -f perf.data
> +       rm -f perf.data.old
> +       trap - EXIT TERM INT
> +}
> +
> +trap_cleanup()
> +{
> +       cleanup
> +       exit 1
> +}
> +
> +trap trap_cleanup EXIT TERM INT
> +
> +perf_record()
> +{
> +       perf record "$@" -- true 1>/dev/null 2>&1
> +}
> +
> +test_decrease_precise_ip()
> +{
> +       echo "Decrease precise ip test"
> +
> +       perf list pmu | grep -q 'cycles' || return 2

nit: I don't think this test can ever fail.

Reviewed-by: Ian Rogers <irogers!@google.com>

Thanks,
Ian

> +
> +       if ! perf_record -e cycles; then
> +               return 2
> +       fi
> +
> +       # It should reduce precision level down to 0 if needed.
> +       if ! perf_record -e cycles:P; then
> +               return 1
> +       fi
> +       return 0
> +}
> +
> +test_decrease_precise_ip_complicated()
> +{
> +       echo "Decrease precise ip test (complicated case)"
> +
> +       perf list pmu | grep -q 'mem-loads-aux' || return 2
> +
> +       if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; the=
n
> +               return 1
> +       fi
> +       return 0
> +}
> +
> +count_result()
> +{
> +       if [ "$1" -eq 2 ] ; then
> +               skip_cnt=3D$((skip_cnt + 1))
> +               return
> +       fi
> +       if [ "$1" -eq 0 ] ; then
> +               ok_cnt=3D$((ok_cnt + 1))
> +               return
> +       fi
> +       err_cnt=3D$((err_cnt + 1))
> +}
> +
> +ret=3D0
> +test_decrease_precise_ip               || ret=3D$? ; count_result $ret ;=
 ret=3D0
> +test_decrease_precise_ip_complicated   || ret=3D$? ; count_result $ret ;=
 ret=3D0
> +
> +cleanup
> +
> +if [ ${err_cnt} -gt 0 ] ; then
> +       exit 1
> +fi
> +
> +if [ ${ok_cnt} -gt 0 ] ; then
> +       exit 0
> +fi
> +
> +# Skip
> +exit 2
> --
> 2.51.1
>
