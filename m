Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6194238C16
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020612; cv=pass; b=VSnXs9FoIHFMAGaFlV2ExyNLwzUuBQINEt1XHL+J8AJXyLcAlk12xUBTaPuoCw6JVPC1zLZPRDGuze8/ZDogpywwRC7mQavLxWcwj35Ulo/EIqR08QG9Dqe4P3IP08x0qKRV7GfBiSl7k1lQ5gGflBcrOhr5sPmbofPFPzaeGb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020612; c=relaxed/simple;
	bh=UozULVDzUKPolXbnCUkBaBk+/uaGKLuB3J341Ee4CsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nC0F3SllT0s9K1BIk5Ynt4HvJKioBEePtgJy/5IA2+oZ6WmK+d9PEcOvs7of27GMitfNODhrFGoGvCvwnnntG4NDtlO46ISBGuC06df24W2Plmpp81F8maEs+ujYdVFbuMnlRu05zJF7R8d9g3sDksyBSbrOUgzLK08gRYwOxwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kD7tazqe; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kD7tazqe"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2591757fbso196155ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775020611; cv=none;
        d=google.com; s=arc-20240605;
        b=jIa4ELZnViO4C4fr9DahIpaCT5QAVwpXKKFSdk3Fh+mk3V+psCHll86Zi/YZ/b2O7d
         N9QVRMGRSndP5RP6EnHU6sY8in1AQNmAHe1yMb/B3qygFGYtIjEgeqbSeM+HvsXTX39e
         IGzAts3fGDiG2C5ZyquMHnsYXpPOJseJl8slOH+9XtKWd6EJk99RvkgxmYVSkWZcGXWk
         6tJoIRVBUv9/Q8AUZDKjwjLx/RST8Wo2iLOAtii1MLeMmKAILNSsLaRT63CwCR+oqzgq
         s7yIEFOVC6S+TLuLkJ1sZOeImiG5zBonHfHQV61ra5VwuUfyooPP61EnL6ZsSnAVFWAv
         q8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MO4ipgrYNZVWvhDAClVaZwpRi790jSEf35wgKaYQA7w=;
        fh=4Sr7H4YbfuhDPQ9el/Pc+xZ2qGVmZvinh3m5rj05UOU=;
        b=d576jZVC7OjDsQwUJa0jWfZ2Of6IPgA6+rYlYBFm+yzRrtuiJyNcDzT3OMvlACUCzM
         royy1POVa1iifYRAoExLygdYU6diXnpjyZylYmjkcFq7LOgn2irU9ZdWxeHJ1Z+5OANJ
         BlXcpuB82cyr8/a9r+LBObXBgQzGfGZtYnktsUFH5kiCpVSGAUectwWssMc2HrBHVu/4
         KoD+GTxiY6p3tVyx0Bx4TVf5nnPuyHxdV1SZ8e9KMCEnPgEw0y7BUyTJAfew7jl2lzo0
         s0RsiTKpsA6P+HxClad9zI5CYhuhUlfLy40KbUENxte4xE+q06rXNhaZskbmSuJ43+t9
         xAHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775020611; x=1775625411; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO4ipgrYNZVWvhDAClVaZwpRi790jSEf35wgKaYQA7w=;
        b=kD7tazqe1d63r++0vSskAkkPoKhRB/VvQ9gsKsIUmkYbrG9+QpVy2uJxFktI2i32Su
         uz6cPnrl7NS3RN3mZuazg9SlaLt+2R5vyhDMC0l893JoZjbd88MahS84iH9Wph5rCdsg
         EpfFRzTQ1HBN6v/5z/+sJ49Hiw4UWZCcl6EbGwTvIqLt49OZjOxA23A/ZSaAw/DlCFy/
         M+2g3NssrYIEOcA39tgRbAE1OYzxMRKE2ximsS0TydEn7mf0ZIwIi2VIEP+kIwPnOBQD
         yLpQ9a7HcEYo5UeCskBXBrpUPe87Qef/aEVwv5ZTO0kQioOhiyou4cj/KhidxNkreHm1
         JItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775020611; x=1775625411;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO4ipgrYNZVWvhDAClVaZwpRi790jSEf35wgKaYQA7w=;
        b=KqMv+/1CSKtgEZO4cwyZvMafRQAxrykA7PmyiLZXzF6A/vWRZZ+1t50qNxYuITACxp
         FRncHxC9fQcAxHz7aRKbmm1mkZ2tlx4tLfRRflPs11XKzhg/NGck4LBBo6kQ8srgQakf
         OS/kLpvce3w/478F++Ehdb/+BuaT7mPqFe49OgzPjjerWi38EgjOpJ7OsXebqJ2y+jTg
         W3eCN9VeRTOoDMZWAMCyQy91q8XPQo7QMTrcYTNtSy0vPRi1fNgScOPsugUCUwvMopHc
         U2aUDj6mZ4e1rMgOOmwni6giluB0VOzhee1S5Pm5B6urZ1vSS+qD1R3g4iJdDzyJaz3+
         gw8A==
X-Forwarded-Encrypted: i=1; AJvYcCWTMYZ8qydT3t5etkeY3BxB4mdSONJWq1UNIZaJilGJR3QjP4BF7lLDSLS2UfMnoAzGmKkZaz+WjzqDlpi5zADA@vger.kernel.org
X-Gm-Message-State: AOJu0YztK9EFbWd3F8M15RPyJiVEug6ZxeCPSRhdsb0AbItUnDIPAGnw
	PmPJTOHkbVqDxL1lF+RjSNNdlik02SvhJKZ3bwpv6iqjBNh6RF44681ZGSP3kZuGSsAsxo9r5iA
	9drKsuGuFNXg9HYoZB/mhep9eKiBxwxvZonQQWRFFwvRaCyqjpZF4hW4+
X-Gm-Gg: ATEYQzz3O7g9z4EWYeOysSLh9ooyQqCO3ffHZ1X9HAYgPUK8yI+BtZhpAWE02JFf9Pr
	9xf53XU5i2JW3k0UkgUrAkh3kAPr/3+yG9Zx2Q114WMPnPQXxyJTzP+2HnuHHepdbdTaOuDxUh+
	h69hnE+Xr0QtDo7izwAtTqgAFtwOhr2Ti/kd66r/23DPBNO5sgZboOE3bAckXDjS024Qlizb+xX
	ECbt+fEY2MdyaYW2dvn12WK6A35B5OX4lO6i1mxqX9BCuRweAAJlk0Ws5LoGPAhhBPluJWypg9p
	x84xt4BX
X-Received: by 2002:a17:902:f54e:b0:2ae:45cc:aeb6 with SMTP id
 d9443c01a7336-2b26b20a5c3mr1451215ad.6.1775020610568; Tue, 31 Mar 2026
 22:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209170814.2009253-1-irogers@google.com>
In-Reply-To: <20251209170814.2009253-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:16:39 -0700
X-Gm-Features: AQROBzBHQ052hA4REd9Ik3ZOIzd2oeevEALZlFrDtdVBkHOl_DO4Q1izMPDV0t4
Message-ID: <CAP-5=fVdR=RvO+8-o8g0UnBAHLcMRRUnG=1t6As_AUwiqW8dgQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests kwork: Add basic kwork coverage tests
To: Feng Yang <yangfeng@kylinos.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 9:08=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add basic kwork coverage tests for record, report, latency, timehist
> and top.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/kwork.sh | 79 +++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100755 tools/perf/tests/shell/kwork.sh
>
> diff --git a/tools/perf/tests/shell/kwork.sh b/tools/perf/tests/shell/kwo=
rk.sh
> new file mode 100755
> index 000000000000..42bfd9382816
> --- /dev/null
> +++ b/tools/perf/tests/shell/kwork.sh
> @@ -0,0 +1,79 @@
> +#!/bin/bash
> +# perf kwork tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# Root permissions required for tracing events.
> +if [ "$(id -u)" !=3D 0 ]; then
> +       echo "[Skip] No root permission"
> +       exit 2
> +fi
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test_kwork.perf.data.XXXXX)
> +
> +cleanup() {
> +       rm -f "${perfdata}"
> +       rm -f "${perfdata}".old
> +
> +       trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +       echo "Unexpected signal in ${FUNCNAME[1]}"
> +       cleanup
> +       exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_kwork_record() {
> +       echo "Kwork record"
> +       perf kwork record -o "${perfdata}" -- sleep 1
> +       echo "Kwork record [Success]"
> +}
> +
> +test_kwork_report() {
> +       echo "Kwork report"
> +       if ! perf kwork report -i "${perfdata}" | grep -q "Kwork Name"; t=
hen
> +               echo "Kwork report [Failed missing output]"
> +               err=3D1
> +       fi
> +       echo "Kwork report [Success]"
> +}
> +
> +test_kwork_latency() {
> +       echo "Kwork latency"
> +       if ! perf kwork latency -i "${perfdata}" | grep -q "Avg delay"; t=
hen
> +               echo "Kwork latency [Failed missing output]"
> +               err=3D1
> +       fi
> +       echo "Kwork latency [Success]"
> +}
> +
> +test_kwork_timehist() {
> +       echo "Kwork timehist"
> +       if ! perf kwork timehist -i "${perfdata}" | grep -q "Kwork name";=
 then
> +               echo "Kwork timehist [Failed missing output]"
> +               err=3D1
> +       fi
> +       echo "Kwork timehist [Success]"
> +}
> +
> +test_kwork_top() {
> +       echo "Kwork top"
> +       if ! perf kwork top -i "${perfdata}" | grep -q "COMMAND"; then
> +               echo "Kwork top [Failed missing output]"
> +               err=3D1
> +       fi
> +       echo "Kwork top [Success]"
> +}
> +
> +test_kwork_record
> +test_kwork_report
> +test_kwork_latency
> +test_kwork_timehist
> +test_kwork_top
> +
> +cleanup
> +exit $err
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
