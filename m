Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384384;
	b=hELTmAbOwhbjLdeeE260mcibsk+QJ2uhx2rPVVyvQ/rlpD7owumCYKfNg5S5q3O7AfOz
	 mqPPKo33ZKHJ9FZOcZUqHByzQh5c3AHXDtMhk1B9MPynSx/pKVHPGacBqTUZmdEkVylb1
	 bADM8Pn4/0CmJBjopbgyPfXndWNCyP8dE1bbhyOJbsfnQ9PE9HPPzHKECPFX/Tlkxf7Mo
	 oPIru3RCSdbyq4yZa/IFSqh0WzJpd6OgRT691YRkavlZEfApwTC9FiKt6eXBpdtN1l02c
	 7zOtQrFG31ZB1mxNUkw5tXabqF9MuX9jWgh2U+WnQynuTrVgiKGa7Jeew4BxP2WKJnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VQ1pmYEI7+qDTnrXtHqKLEZz08P1JIx4Ry5QQ37niQo=;
	b=lIrozyu03GGY/sa5kNUFxWvV3LlApx/+mHjh3cmiCG3hHkuZ4ue3vkUUBgPaPq5CrboH
	 akjYA1Sho6vW2WiAhvBTJ86qfu095gSGhYb8JcJ713qDvmLO7bAd/WMccnANQiM4nD4N6
	 ivRW29zMkF8m///gDMwyfbyO2+W33cVbYQcSRH1UhHxLssWq5NS+FJ4ZwX5qFl31tbe9h
	 OK3iwd+RNSWI5F0CAxcm4+z7Ta7s0YeJq3SHSOSxfI3tM8nG1m6yCty1GZlMtl/JNZW6E
	 ZWS+GFrFLYTOuGsCGoUknYVfzSo8WSObMAniaWtLPgc/glmcLb1Y2KvLmqWa8tmEv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7gcfDlE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D2606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7gcfDlE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB01F000C6;
	Sun, 22 Nov 2026 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384384;
	bh=VQ1pmYEI7+qDTnrXtHqKLEZz08P1JIx4Ry5QQ37niQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7gcfDlE3rFngTj5aEoUz35NpiND0VTYEDxiuRxgIRLdeOO0TGwrYhLlpbsbynF3r
	 4F3drN2Ook09cH1GorFeUM3uRrSQk9U0L/YVrei90NqMD5WmLfplbvDDbKfn6inmZW
	 UEPByvQWL90BNqUHXyNeVNwq1WnXzs7TxZucGkaq28u2oE+JtjX8yH+H0prZ6SHZsl
	 3vRa0GPMxdNb1gtu10e+GLWNFsZK9mBknufXKJy3t9Bw3DELkEU1G9qtfkbRIrCvbR
	 a9PCpHc55CvlzMhfSjgZfm27S6iUINaAe324tWkCnhPcfOKHGs4lR5xSO9O/R5+rk9
	 Ia6qMcEhtQUFg==
Message-ID: <sashiko-outbox-228396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/19] perf test: Exercise the annotate stats output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261122214025.16769-13-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
 <20261122214025.16769-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 21:53:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf test: annotate_stats.sh fails on archs without operand
  extraction
- [Low] perf test: annotate_stats.sh awk check fails when bad type count
  is 0
--

commit 88aa12c83c2352997344ef608d4e215c23a1b93b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Exercise the annotate stats output

This commit adds a shell test verifying the --insn-stat and --type-stat
output of perf annotate as well as the warning when --type-stat is used
without --data-type.

> diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/=
shell/annotate_stats.sh
> new file mode 100755
> index 0000000000000..5d8a687e85ecb
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate_stats.sh
> @@ -0,0 +1,172 @@

[ ... ]

> +# Each event annotates the same instructions, so the two-event total is
> +# twice the one-event total.
> +one_total=3D$(awk '/^total / { t =3D $2; sub(/,/, "", t); print t; exit =
}' \
> +	    "$perfout")
> +two_total=3D$(awk '/^total / { t =3D $2; sub(/,/, "", t); print t; exit =
}' \
> +	    "$perfout2")
> +if [ -z "$one_total" ] || [ -z "$two_total" ] ||
> +   [ "$two_total" -le 0 ] || [ "$two_total" -ne $((2 * one_total)) ]; th=
en
> +	echo "FAIL: instruction stats do not count every event" \
> +	     "(one event: ${one_total:-none}, two events: ${two_total:-none})"
> +	tail -n 30 "$perfout2"
> +	cleanup
> +	exit 1
> +fi

[Severity: Medium]
Will this fail with exit code 1 instead of skipping on architectures that do
not implement instruction operand extraction for data-type profiling?

Unlike the perf mem record step later in the script, the cpu-clock and
task-clock recordings run on all architectures with DWARF support.  However,
arch->extract_op_location and memory operand parsing are only implemented on
x86, arm64, and powerpc.  On other architectures (such as s390x or riscv64),
__hist_entry__get_data_type() skips every operand because op_loc->mem_ref is
false and op_loc->segment is INSN_SEG_NONE, returning before incrementing
istat->good or istat->bad.  As a result, one_total and two_total are both 0,
and [ "$two_total" -le 0 ] fails the test.

[ ... ]

> +# The total is the sum of the bad counters and of the good ones.
> +if ! awk '
> +	/^Annotate data type stats:/ { stats =3D 1; next }
> +	!stats { next }
> +	/^total / {
> +		t =3D $2; o =3D $4; b =3D $7
> +		sub(/,/, "", t); sub(/,/, "", o); sub(/,/, "", b)
> +		total =3D t; ok =3D o; bad =3D b; next
> +	}
> +	/^[[:space:]]*[0-9]+ : / && $3 !=3D "insn_track" { fields +=3D $1 }
> +	END { exit !(total > 0 && total =3D=3D ok + bad && bad =3D=3D fields) }
> +' "$perfout"; then
> +	echo "FAIL: data type stats do not add up"
> +	tail -n 30 "$perfout"
> +	cleanup
> +	exit 1
> +fi

[Severity: Low]
Can the bad =3D=3D fields check in awk fail when all sampled memory events
resolve their data types (bad =3D=3D 0)?

In print_annotate_data_stat(), PRINT_STAT() only prints non-zero counters, =
so
when bad is 0 no bad counter lines are emitted and fields remains
uninitialized ("").  Because sub(/,/, "", b) turns b into the string "0",
bad =3D=3D fields compares "0" against "" as strings and exits with a failu=
re.
Comparing bad + 0 =3D=3D fields + 0 (or initializing fields =3D 0 in a BEGI=
N block)
would force numeric comparison.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122214025.1676=
9-1-acme@kernel.org?part=3D12
