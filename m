Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A89343D63
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116802; cv=none; b=o3rHlHVQIKzqRwfrcDq62w0Z6ibhjZ9Np7qd/pG90xGd3Rbac1PsiU1e6O+an43FjTwzCNjQcI5DiF9PjtXfxzxVNgPjzz5D51/PqIpOyjN90WPe7DsxvAOquI6Vzlr0k+syyjOfLRmUsGZaC7OurEl7gP82rrbVkv+/mCp1B0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116802; c=relaxed/simple;
	bh=ZiXGxbRRtmn7yP05xyT+qjrNGTNJHnyMz62xupc38c4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fcdwyDTcAURnew8YotUPYy+5X+kE57EOdYGkBPicyUrj3Sn5/QrHB2QMSlFYixAUjcKVtw29Uz+Y4Acpo3/PWrHUtoDFJDiaNM6QDsONicObquMsMDokxnZHUw16nnm0Ut46L+K3oL2Xxi5j7c59P01x7VIA1YbTmR/lp9mRFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIEfttdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIEfttdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5121F00A3D;
	Fri,  7 Aug 2026 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116800;
	bh=wxv2C/0ZpbVzMHmDE+QjBCbBXgwF5oHIKegS8vGKMlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mIEfttdwM972t0gUl11foecO/pYfUcVASXky4RJWDRFgEMyjasaD84Vtw5cvldll7
	 XerhBauQkg29nES6d4Zgx7aQ8/tTtoFTT+74mJLQUN7qjTHKhrzFzaySmaXhEq5+L4
	 uN/ClAfBfXqSwXoNxMyJCD4IratLHVcj3NLfF5s4cHwHSlMYUcbXlKpzpn7Enn/6RJ
	 a3WBn7PnjVBjZ+USzvUXm2ye/JgEpxo/oL5Cck7nyqcXfj4HEm7CjhvHHiflZRdJ4J
	 d3xQs3qw1OUfOPdUuSWIS66U8sAOE+Ve1Ms/90gI0AE1J6Rn3o2hwnhXel5pp2aZN3
	 hMWZa2oqKeFwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 5/6] tools/perf: Add powerpc HTM auxtrace event
 processing support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807144135.2607-6-atrajeev@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-6-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:33:19 +0000
Message-Id: <20260807153320.BD5121F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] If multiple `PERF_RECORD_AUXTRACE_INFO` events are encountered, =
`session->auxtrace` is overwritten without freeing the previously allocated=
 structures, leading to a memory leak.
--

--- Patch [5]: [PATCH V5 5/6] tools/perf: Add powerpc HTM auxtrace event pr=
ocessing support ---
commit bdf509e26b28cea056c3306c8b70fad62802e9ca
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add powerpc HTM auxtrace event processing support

Add the powerpc-htm.c decode stub and wire the dispatch in
perf_event__process_auxtrace_info() to call
powerpc_htm_process_auxtrace_info().

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> new file mode 100644
> index 0000000000000..0ef7ecd18c6f3
> --- /dev/null
> +++ b/tools/perf/util/powerpc-htm.c
[ ... ]
> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
> +				      struct perf_session *session)
> +{
> +	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
> +	struct powerpc_htm *htm;
> +	int err;
[ ... ]
> +	htm =3D zalloc(sizeof(struct powerpc_htm));
> +	if (!htm)
> +		return -ENOMEM;
> +
> +	err =3D auxtrace_queues__init(&htm->queues);
> +	if (err) {
> +		free(htm);
> +		return err;
> +	}
> +
> +	htm->session =3D session;
> +	htm->machine =3D &session->machines.host;
> +	htm->auxtrace.process_event =3D powerpc_htm_process_event;
> +	htm->auxtrace.process_auxtrace_event =3D powerpc_htm_process_auxtrace_e=
vent;
> +	htm->auxtrace.flush_events =3D powerpc_htm_flush;
> +	htm->auxtrace.free_events =3D powerpc_htm_free_events;
> +	htm->auxtrace.free =3D powerpc_htm_free;
> +	session->auxtrace =3D &htm->auxtrace;

[Severity: Medium]
This isn't a bug introduced by this patch, but if multiple
PERF_RECORD_AUXTRACE_INFO events are encountered in
powerpc_htm_process_auxtrace_info(), does this overwrite session->auxtrace
without freeing the previously allocated structures?

Could a maliciously crafted perf.data file containing multiple such events
trigger a memory leak here?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807144135.2607=
-1-atrajeev@linux.ibm.com?part=3D5
