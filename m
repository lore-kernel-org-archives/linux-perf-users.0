Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7D18A6A8
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785036825; cv=none; b=L2mCFJS3PFMMr24EfT1DM7zvar22HVaDvN+zeZf5hPxqLUgSvVIOXCoUirVga41oF2IN7o1FXwyTfHoYbKSjyi6xSYFq42bNPKcKcss4sQiHiZgmAufAcTEUKSLMHe3onNRmCdSWgjeRAzT5UFEWzVBz5bG52C2LQzF9S8LHZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785036825; c=relaxed/simple;
	bh=8jEFEMRXdsB1cPG4aFesLd9cSPN8eNOSfvv5X3fydjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lnt3sPo16nYcXebbxCDOT4shfs6ngEkormu3VD2xK98aDgtH/b6c8GQA4bCSgFkYFD+o7pM5AHFoprnXl2P09Rq+GoZook8ej9FqIQd136YtC0zTbrraZbYo7qoL0DKNPMzgTzZh9eJszJurHZrGPaQPDV3icJ9tnpbfuiYtEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCpiyIqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCpiyIqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A31A1F000E9;
	Sun, 26 Jul 2026 03:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785036823;
	bh=H675M+OmKKZDdINaNmaMEovTYP42Saz/fivSbVTTHV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCpiyIqPDg0P2OWBojfyy93usj/SBZBQz8BB4BOQ4GO79/8KRMoMdfTpFEUbLP4KY
	 Pthq6TQ0VrbnVCPglAIpVvUuY/N1Gaz9xrt37P/jy7c6yasjgs3u2M/QF7k6WLV4mi
	 f+ti0BtwE7lyWDQFpJw3YxqZv7MqJ5fqJ+Vj/WtGvMHrNkHt0HMJisRkMUGdFfpPuA
	 38BUkARUm5+zA2wlQwoXTWMOShHFx76S4PT5DEk5nXTim4lsWaMKPefNuv9qAktE1K
	 YP+/Jpc+6nQQjSZIHVN/u7gZ4qe1nbXqzCabPUZiWJqZKEtdI7qcnpxGYKr5NMCIzL
	 ZqoBoOpWrEGqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf sched latency: Auto-scale latency and
 runtime display units
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260726032533.712462-3-atomlin@atomlin.com>
References: <20260726032533.712462-1-atomlin@atomlin.com>
 <20260726032533.712462-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 03:33:42 +0000
Message-Id: <20260726033343.6A31A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Column misalignment in the 'perf sched latency' output due to data =
rows being narrower than their corresponding headers.
--

--- Patch [2]: [PATCH v3 2/3] perf sched latency: Auto-scale latency and ru=
ntime display units ---
commit 2e23c112768cacfb80cab8592bd0a0612fb05704
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched latency: Auto-scale latency and runtime display units

This commit introduces dynamic scaling for latency and runtime values in
'perf sched latency', outputting them in ns, us, ms, or s. It also renames
the column headers to reflect the variable units.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index b3cf678573e0a..8c83dc423b571 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -1430,14 +1443,17 @@ static void output_lat_thread(struct perf_sched *=
sched, struct work_atoms *work_
[ ... ]
> -	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max st=
art: %12s s | max end: %12s s\n",
> -	      (double)work_list->total_runtime / NSEC_PER_MSEC,
> -		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> -		 (double)work_list->max_lat / NSEC_PER_MSEC,
> -		 max_lat_start, max_lat_end);
> +	printf("|%14s |%9" PRIu64 " | avg:%11s | max:%11s | max start: %12s s |=
 max end: %12s s\n",
> +	       runtime_lat,
> +	       work_list->nb_atoms, avg_lat, max_lat,
> +	       max_lat_start, max_lat_end);

[Severity: Low]
Does this format change cause the data columns to misalign with the table
headers during output?

The updated data row format specifiers " avg:%11s " and " max:%11s " expand
to exactly 16 characters each (1 space, 4 chars for the prefix, and 11 chars
for the string).=20

In the old format, " avg:%8.3f ms " expanded to 17 characters, which
perfectly matched the 17-character width of the corresponding table headers
shown below.

[ ... ]
> @@ -3612,7 +3629,7 @@ static int perf_sched__lat(struct perf_sched *sched)
[ ... ]
>  	printf("\n ------------------------------------------------------------=
---------------------------------------------------------------------------=
----\n");
> -	printf("  Task                  |   Runtime ms  |  Count   | Avg delay =
ms    | Max delay ms    | Max delay start           | Max delay end        =
  |\n");
> +	printf("  Task                  |   Runtime     |  Count   | Avg delay =
      | Max delay       | Max delay start           | Max delay end        =
  |\n");

Because the "Avg delay" and "Max delay" header columns are 17 characters
wide (" Avg delay       " and " Max delay       "), shrinking the data row
columns by 1 character each will shift the subsequent data columns leftward,
breaking vertical alignment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726032533.7124=
62-1-atomlin@atomlin.com?part=3D2
