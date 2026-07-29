Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A743E317C
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330062; cv=none; b=BlxkVGNJx/jD6msoeZ3Fqh2eWotnaWqcqqcBcSBQAAMQ9hYhSpq6NWDaEVwB67+cyz9kMj4LnPh0Ioaj94UIdxBy9FaBBybQnK2vgsM7dTKrbe7VOK4Em6CHn+RCefTw4xy+nEGdkom9JMzeBxuUYvMivngcZnBCjSGkDzY6wx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330062; c=relaxed/simple;
	bh=En/NTCjAHdEEaVJBJStF1Uk+TELxxXpFpmBXIN58Qs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=awTd5C3RxNpDkPkmofWv5aMZf1Ih0QVDH1tqf9ZkamtmEIX4iO8FurNf6ssmmXFwYNmgZfsfLgFiBP6naCo0I4jb36Hs47XTIx1Z/fqARBoBJ/CdUWEJFe6h6dbtHeWPVjzJ3pkNTL2WzD/vuNwe1HGC4WOPyrnkA281dwERrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udfz/oIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udfz/oIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB2C1F00A3A;
	Wed, 29 Jul 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785330060;
	bh=VjGyBYcI9mEPERKMAodm4cnebWMXfC2gFQys0Q20gfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Udfz/oIMRVCAzEEX+kW0FGG2opPWCfXPLV0ZdWL8lMdQHHnWp80L8NDJa9I7pIgpn
	 4+jppBMDR5F49mkxihZs3KRcNybr1/4eH1ffWbhsz+nMp2kkiwKG1k0QQOfS5eYd/a
	 ELaGUF+6PuSE2aqZU0dU5IS7M5mRsb4taMUYarS4qz6KzLK1dQiO+lX+Tqn7jUpE5t
	 enUxosbgjlyVNRfB/Ao2QXJSb/dyu5vpSEuP6oh353DiKPuhD1SgR5Ouwq1+IunLl5
	 BSqvGqvKRHhmjJJh6qj+81JPaE44vdFWt/B/rCD7EAouGuc87r/a/ToDo3w+s4/rOo
	 L5o1LRXazxgHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729124400.65009-5-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
 <20260729124400.65009-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:00:59 +0000
Message-Id: <20260729130100.7DB2C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The use of `perf_evsel__read()` causes silent read failures for si=
bling HTM events in a group, leading to premature termination of the record=
 loop.
--

--- Patch [4]: [PATCH V4 4/6] tools/perf: Add powerpc callback support for =
arch_perf_record__need_read ---
commit aa9cd81264b9ba7389f3532c4f16fea15643247b
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add powerpc callback support for arch_perf_record__need_read

This commit implements the arch_perf_record__need_read() hook for powerpc.
It reads the count for every open htm evsel via perf_evsel__read() and
accumulates the values into total_pending_records. A non-zero total means
at least one HTM target still has records pending.

> diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/power=
pc/util/evsel.c
> index 2f733cdc8dbbe..3c7ccc955b0af 100644
> --- a/tools/perf/arch/powerpc/util/evsel.c
> +++ b/tools/perf/arch/powerpc/util/evsel.c

[ ... ]

> +		for (x =3D 0; x < xyarray__max_x(xy); x++) {
> +			for (y =3D 0; y < xyarray__max_y(xy); y++) {
> +				struct perf_counts_values count =3D { .val =3D 0 };
> +
> +				if (perf_evsel__read(&evsel->core, x, y, &count) =3D=3D 0)

[Severity: High]
Does this code silently ignore read failures when the HTM event is a
sibling in a group?

If a user groups the HTM event with other events (e.g., using
perf record -e '{cycles,htm}:S'), evsel__config() sets the
PERF_FORMAT_GROUP flag for all members of the group.

When perf_evsel__read() is called on the HTM sibling, it will delegate to
perf_evsel__read_group(). The userspace buffer size is calculated using the
sibling's nr_members (which is 0), but the kernel enforces event->read_size
based on the group leader's nr_siblings.

The kernel then rejects the read with -ENOSPC because the userspace buffer
size is smaller than the required group payload size.

Since the error is silently ignored here, count.val remains 0, which could
abort the drain loop prematurely and drop the remaining records.

> +					total_pending_records +=3D count.val;
> +			}
> +		}
> +	}
> +
> +	/* Collection is complete only when ALL hardware queues have no pending=
 records */
> +	return (total_pending_records > 0) ? 1 : 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729124400.6500=
9-1-atrajeev@linux.ibm.com?part=3D4
