Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E34352005;
	Tue,  9 Jun 2026 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982903; cv=none; b=kmKKYA7/UMVKnAaQO8EzB4UVbNIdKQhIaMUekYLEU2L+9dVTNbjA9ptqD1kn9ScT8alW5OqNMpWk/kE8LdGwGDFT+IkozlSyVJTPZxtxb8X2BPnBjNrrwdmGVSeohBUaLvCtJWux8TVrGShPnLbn4uVv0f0xKGsQ7CbY9vIWmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982903; c=relaxed/simple;
	bh=miGvQ7OcNkP1xM07xmH/WdSP/NOx1KgDd0KuKha1J0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L7iRV/wrWUjmyAbcCB8vT3wT5G5L22oKANzLZbTfBVMVSNVweAIWzWS+WFTwMqSOiy4483KhvXTx9wS+tMS2YjA3cpBMVkYyi54TJSeo5hmRXj9irCtUYTQdsjnXVFcAUKW5PnM+8k0P6e7lSXGJ+6NDgLiE3DyB2B7N6Qtirvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz8/VuQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz8/VuQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977BB1F00893;
	Tue,  9 Jun 2026 05:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780982901;
	bh=czVjotyfZexn9adB3RFUFnF4NhcdTAcg3FtXwJl12t0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iz8/VuQ/PzArOPT5oN2M4U0JlU7ovkP9Vg1qBg16gzc+gadrIH9C9W0EZs4Fr0INI
	 bzM84fwWUFRu+nP4X4DBlQTqImldlMfz/SMWzpGiFMmO/9rxGl/WNr3JCWS9c06Cf+
	 PVmjM17jntGSxa0T0wu2H6dI4PD3q02Dviu4VM6iZLz68RTq6+Hwc3COJPwvHB7Ewr
	 6+87RrqlHvV3uAnXctXhRobro8Iu4sxV+qe2cHfHp9BkJOl2hr91oLfsgQUjtf3nIH
	 AtOXqPjxAyHKR++DbxtTgy7nCD06EMsKa5U8EUnHQH/qccTuGKQZ2C1UgBGjo2RsEm
	 gS+dPbES7rRTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] perf test: Enhance annotate test coverage and
 isolate config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609051759.405027-6-irogers@google.com>
References: <20260609051759.405027-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:28:21 +0000
Message-Id: <20260609052821.977BB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Premature script abort and unreachable error handling logic due =
to the global `set -e` shell option in `test_disassembler`.
- [Low] The cleanup function unnecessarily attempts to delete temporary con=
figuration files that the script never creates.
--

commit 4dda72bcf9505cc21e386908e19f007d3ab5a6ec
Author: Ian Rogers <irogers@google.com>

perf test: Enhance annotate test coverage and isolate config
   =20
This commit updates the annotate.sh shell test to cover different disassemb=
ler
backends utilizing the new command-line option. It also attempts to isolate
the test script from host environment pollution by exporting
PERF_CONFIG=3D/dev/null at the start of the script.

> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> index 689de58e92384..d3bafa7e3db55 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh

[ ... ]

> @@ -23,6 +25,7 @@ disasm_regex=3D"[0-9]*\.[0-9]* *: *\w*: *\w*"
>  cleanup() {
>    rm -rf "${perfdata}" "${perfout}"
>    rm -rf "${perfdata}".old
> +  rm -f /tmp/__perf_test.config.*
> =20
>    trap - EXIT TERM INT
>  }

[Severity: Low]
Is this cleanup necessary?=20

Since PERF_CONFIG is exported to /dev/null at the start of the script, it
doesn't appear that any temporary configuration files matching this pattern
are ever created by this test.

[ ... ]

> @@ -106,8 +109,61 @@ test_basic() {
> +test_disassembler() {
> +  disassembler=3D$1
> +  feature=3D$2

[ ... ]

> +  perf annotate --no-demangle -i "${perfdata}" --stdio --percent-limit 1=
0 --disassembler "${disassembler}" 2> /dev/null > "${perfout}"
> +  ret=3D$?
> +
> +  if [ "x${ret}" !=3D "x0" ]
> +  then
> +    echo "annotate with ${disassembler} [Failed: perf annotate error]"
> +    err=3D1
> +    return 1
> +  fi

[Severity: Medium]
Because this script operates with set -e globally, will a failure of perf
annotate immediately abort the script?=20

If the command fails, it seems the shell would terminate before reaching the
ret=3D$? assignment, making the explicit error handling and logging dead co=
de.

> +
> +  # check if it has the target symbol
> +  if ! grep -q "${testsym}" "${perfout}"
> +  then
> +    echo "annotate with ${disassembler} [Failed: missing target symbol]"
> +    err=3D1
> +    return 1
> +  fi

[Severity: Medium]
Similarly, since the test_disassembler function is called sequentially
without protection, will returning 1 here trigger a set -e abort at the call
site?

This might abruptly halt the entire test suite and prevent the remaining
disassembler backends from running, rather than continuing to the next test
as the err=3D1 assignment suggests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609051759.4050=
27-1-irogers@google.com?part=3D5
