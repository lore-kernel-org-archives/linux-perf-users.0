Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CC2D3220
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171134; cv=pass; b=I0bE7z/i4mqCzbtMbybuaYqFEj3dik17KphoP3K2yaT7PDroAnH15OxAGfiYEdnDdbkPsQ+GbLapqebFG638Qblgli4bLrSwiYsmjBzavvtvP63KekuvVYx3mpAk764NF1tkIFoWDyZdmAA0ZjTK13Dvmkqk5GaqZ8a4fkndXOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171134; c=relaxed/simple;
	bh=c+Lwww5aFmDJS9j7ccOUY/km+EUHzpLouGIHjYTL8OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgTH74HsFMD5o79YV+4QYry/ZL2/c9rf6wBVDcpkirDVlaReBuN2OTHK1Vja32OwBjm21U/VGHohksSyhTPmJNzBD+JmErZGNh0vPBjwc1VfhEE7akB7xYpGoP6avxosO8d9hbexAU0PajB8SgNnmJzca9nYJmu5ChnnaA6b+1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZL7qlbL; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZL7qlbL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so27605ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 12:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773171133; cv=none;
        d=google.com; s=arc-20240605;
        b=cPD9Otqcp6RjbdMABM5tvvTyRERDJn1BwJcB4IlkZHbXN0xNBe2Of2PtbY+5aFYKVY
         W/2LWTsFeqb5wmNda1q57D+OVqHrXcpm2z/XgHB7r2ddiSSbRfqKmsFsK0mwZBEgA9AS
         h11MedXWj7jPHMFhPEnjy/ewnoPXqgrYPO9nNoCwTUMhGWx0CcdkvF+2ypgg+pTdFDmG
         EZt1Af6LrKjRpc8jtKi9enwJv+mWz7baEDAT099TpQhoBPrh44B1zI62AryUuTpMEJY3
         gbJ2UggeGIBxJaG8sHPSN/4zSpDf7NlBcnc1WdpJx59RVtaOuicLkN2npdzyIfOu7aBG
         Bvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FC2ao4RwJ2wtyHQLLy7mp0F1062Tg2xBeih20w3zOm0=;
        fh=0l/ulX36wPcRaxhWgyoX9IHzVrFUwTxPg/NDqyhFKyM=;
        b=F84OTYjbWYCtyUWH5s7EbFde7IxpAobFB0hAgr9t8kzjsn0MynstqEBhVdfXZlxGM3
         h9lSmDRABnM/A3ZZ+H8CetxS0as9SxjPi6Q4ZMpDzrE+gp2xnrLP5W8539MCBiCsdNZv
         EU80Qi8BPgcR68yzWfmgeeyIOFHcohbUaM6syiRMByyNqCrygkCy9JlJKVgY57SFt4lP
         mS66dACYny1ciHbKaZEcIL3m/0wVHlyqd6dNryMlco2cYZs3Llz7duqjGOGe8PjZhlIg
         VPNE7OligZnS+zaprVaJ2dLHhhcOI716Gl/f0v5o+Ss2Xr+30gSFiBoeQTdYDCFZ4XPP
         kvwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773171133; x=1773775933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC2ao4RwJ2wtyHQLLy7mp0F1062Tg2xBeih20w3zOm0=;
        b=qZL7qlbLypkguFZXZ0z3+2nF3Epq8m6EhpRMgKyLcF8d2Fz4FYpcVQi1XWKnuUNgm1
         Mx/77D5hnYoOA+FYLIG4Eha6IoJTOhP/pX/TYT1z6B7685dSgu/Wpfz1QxMyWM0RZ27U
         8WwwGDikwy35bmnB8tDEQAxbzTiYgT0DlsTmvRuG6a4AjsYZRQYBp4uQ2GtCiOqbb32J
         v97bxE8gJN3CrA2wvuVhK18W63H2SrU8X1gB/sntuG8qlcE35dshhb67TIAZzy6V1tLN
         EjbQ9oq0k6O0pcPwP76M3gbDozo38GZEnbdyYnDyFmO4gUPtQ16NcoLl1K74QotlVwao
         jO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171133; x=1773775933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FC2ao4RwJ2wtyHQLLy7mp0F1062Tg2xBeih20w3zOm0=;
        b=O6BOHaEoPqi5mbCNHd5EZATIZbBaPVnyDzu/jl4L6KcOUzHvtr8YrWlxvtu4Yc8kzz
         bBMFNtPZCgdvT0p7MKFxT9LvfzeTmVlmN+iN48xu0aQ7kkt1xHRKrT2D+McHAtmGIGlM
         almHRnKXZZE6rUl5Nfh1nVOVkhDe8DiqKJ5MYRPneROT90rEZ4mOOha14ExNQzDTGD5Y
         zenn7xjbxei+gRPScYZ3O24+1EUlQ8iURTAkr8cBMOYvyNgFIwhxtm7f6+itbW6spIg0
         aB3nKFxr2nSvbSPWIK6MOnbDfNbXZ/IDvW+Nhs7Hhkq+f5GTBhT4sK/RfaCWh/3RP4wM
         tabQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjEoQNR1bJOd3pQjWnEXOhvwar2t2bQDSU5vNmGu6HemQdZkjaATKQxhe1jWK2+9AKW0pwpQB02K0vTHu5iPDi@vger.kernel.org
X-Gm-Message-State: AOJu0YwIK6D4D+ZvU7V697xF+NIPdwKfNfgtjL0Vwy3M3Qzz5ZoVLDP0
	Hmg0oDspA01Uxnj6a/8VG+iYqlR3OBU1u1wvyGjG2mHpHlBzIh111V18tol/v1Ooxf8sNpLP4sF
	9lfCxRCStN4V+Xcz3u88N2DwoGJQECrDMLRaPsaTK
X-Gm-Gg: ATEYQzwK9vSJCjzCOdtHlKL4eCcHNNmXnX1uUIRoTNMjnKtKW0CAwzbFJSkZfT9jjcj
	AmyvFE+MoGIFtuVreHkwX8H4atjrdVL+C1wOrHllYgYoO4nX4Wk2h6VN6pslnG01mQCez8op2aO
	nICHwry+UJvkAdhMCVC5qRMASm9t6x8p9OtHH4mn8yvQccf7zNbWGp+mG7P5yUS/9ZP5yJQqB+9
	ftKbnVz3J1xXWFNIu5vQhySQJDeiwj3cUS48gQTTAs1yq+sMDmqx/klSYvP5wkA3PSc6M2WG/+o
	fisRlM82h2myeXYUXEIA0QSpSlIUqZ8AzrKDlw==
X-Received: by 2002:a17:902:ef4e:b0:2ad:6f9b:7817 with SMTP id
 d9443c01a7336-2aead3ded5bmr539035ad.22.1773171132624; Tue, 10 Mar 2026
 12:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310175951.29500-1-cel@kernel.org>
In-Reply-To: <20260310175951.29500-1-cel@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Mar 2026 12:32:00 -0700
X-Gm-Features: AaiRm52NRWiZ34NXqHSCqNC8PjzehKNM1x9Al9I1vrpyTkBKgKDOBWkMJCxasLg
Message-ID: <CAP-5=fUA0BiCfgqgy_ik8iAhABQxYtFhKiUiEGrOCcF2jAqhfQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf synthetic-events: Fix stale build ID in module
 MMAP2 records
To: Chuck Lever <cel@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:59=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote=
:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> perf_event__synthesize_modules() allocates a single union
> perf_event and reuses it across every kernel module callback.
> After the first module is processed,
> perf_record_mmap2__read_build_id() sets
> PERF_RECORD_MISC_MMAP_BUILD_ID in header.misc and writes that
> module's build ID into the event. On subsequent iterations the
> callback overwrites start, len, pid, and filename for the next
> module but never clears the stale build ID fields or the
> MMAP_BUILD_ID flag. When perf_record_mmap2__read_build_id()
> runs for the second module it sees the flag, reads the stale
> build ID into a dso_id, and __dso__improve_id() permanently
> poisons the DSO with the wrong build ID. Every module after
> the first therefore receives the first module's build ID in
> its MMAP2 record. On a system with the sunrpc and nfsd modules
> loaded, this causes perf script and perf report to show
> [unknown] for all module symbols.
>
> The latent bug has existed since commit d9f2ecbc5e47 ("perf
> dso: Move build_id to dso_id") introduced the
> PERF_RECORD_MISC_MMAP_BUILD_ID check in
> perf_record_mmap2__read_build_id(). Commit 53b00ff358dc ("perf
> record: Make --buildid-mmap the default") then exposed it to
> all users by making the MMAP2-with-build-ID path the default.
> Both commits were merged in the same series.
>
> Clear the MMAP_BUILD_ID flag and zero the build_id union
> before each call to perf_record_mmap2__read_build_id() so
> that every module starts with a clean slate.
>
> Fixes: d9f2ecbc5e47 ("perf dso: Move build_id to dso_id")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  tools/perf/util/synthetic-events.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index ef79433ebc3a..ddf1cbda1902 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -703,6 +703,11 @@ static int perf_event__synthesize_modules_maps_cb(st=
ruct map *map, void *data)
>
>                 memcpy(event->mmap2.filename, dso__long_name(dso), dso__l=
ong_name_len(dso) + 1);
>
> +               /* Clear stale build ID from previous module iteration */
> +               event->mmap2.header.misc &=3D ~PERF_RECORD_MISC_MMAP_BUIL=
D_ID;
> +               memset(event->mmap2.build_id, 0, sizeof(event->mmap2.buil=
d_id));
> +               event->mmap2.build_id_size =3D 0;
> +
>                 perf_record_mmap2__read_build_id(&event->mmap2, args->mac=
hine, false);

Thanks for the report and fix. One thing this change will fix is the
dso lookup, as the previous mmap2 event's build id would be read by
perf_record_mmap2__read_build_id for the dso_id. The other fix
addresses the written out mmap2 event, which now won't contain data
from the last event when reading a module's build ID fails. If reading
the build ID fails, since the build id misc bit is clear we should
probably write the maj, min, ino and ino_generation fields. In
perf_event__synthesize_mmap_events these are populated by the reading
of the /proc/pid/maps file but in
perf_event__synthesize_modules_maps_cb and
__perf_event__synthesize_kernel_mmap we probably need to stat the file
if possible - mind you the non-build ID code there uses an mmap event
rather than an mmap2 event, where these fields aren't present.

So:
Reviewed-by: Ian Rogers <irogers@google.com>
But I think we can improve the perf_record_mmap2__read_build_id when
filename__read_build_id fails.

Thanks,
Ian

>         } else {
>                 size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u=
64));
> --
> 2.53.0
>
