Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53137F732
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548684; cv=pass; b=aOTxnMovEygN0NEJgK0vlVNIP9vOKHomZJ+ZqGljHWu/sZs2MxJk0T5QxyRWZ7iyvEI0skLJgkiEj86mTvlnm/a7q8hLfsc5NPtLSTL1u3nCh2yA6/dX6ZW4+zeOUSBz3Rkw4GRIE/zA8bUSMubK89g7uiSe2KRlCv6gY2OFhKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548684; c=relaxed/simple;
	bh=BJEwi7lwFkfqZANzBb4tMG9GQSMQ31eA76wr8WAAxz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sztdGjrdiqL+iMmt3oJRVaZ4F3g+KTh+S1lojnYO+89xZD64KIxnxJTI2nPX/ttup0fqOOdCRD+4E/hjg8OPwGXKujOymop/LSkp1Yla8JBjH58IfzEve7MAhyWy9xjzFShJOqklbA3q8UgwwYzWGUs0oRRRqUgwzMIqogxe2tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0O8DIi7; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0O8DIi7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c67ea316caso8285ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 11:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781548682; cv=none;
        d=google.com; s=arc-20240605;
        b=GVFqOSc6+deSVQnjdzyu56EPPTI1ufIA7+j67ckQhT1JKH8XxSE3Cr0/SXCgft26u/
         p+aLCFFSj2eKhec25/lBS7wTNPWybGdh2tQdrvXUPG4hK4ylUZlAtb5VL1E5a6Arkiu0
         UxoruG1WXsKuriEO50MtOGAUAzu4x6lvR6npzo2UAycO7j098zl8qqMdgBbHKIBXzFVZ
         LhZsQjoicAZRtt5V0yZHkDfQZPMZZV6OQgIYBCvtjGjEd0eoMqvl96DXD2i9mrszgj0y
         lo7wy4PdBbojO+flevbsyVenEmpmtDSXakKCn7WYD8vKuCIyJx8QaHRSQA2xwISSCglM
         L90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7QL5zCyb7DMb7x/3/dZnW21sfO/tt0T7dScZLGhrII=;
        fh=45QhFsrx3nW6J8uf1dxdHGDiMccxsofPmjiNFoYi1kI=;
        b=SHZwDX/C9UkNvRycPAKj5KvcNI5ZkTZ5BU7BDE9k9dHBvn8uE1PLu3Zte9zQSYZ3M2
         BICF9Li31D6gFkguuU5463+cSoPFB0wBTwgShfLRqVrjtN11UK4ekjCeGUUMDuW5lUn4
         D89c8o5Vw8AqkpIY+TpmA1yCkWfGx0oUe1gj3VIveiwDi8FvHVUGzv0QEt48hvQlEJNz
         fOKn2n5SUwHepBSCTqjr8hAyyrSic12sL/YyPV8uEwLhnbGl7SR73KPcR3XIEMX+qFXa
         QtLX8VXRcZ9VeDiI3OX4PQqYe8ABU8Obf1fB8gtONN2uSu6cQy7CTDsCq6Wtr3pgg4s7
         1tpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781548682; x=1782153482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7QL5zCyb7DMb7x/3/dZnW21sfO/tt0T7dScZLGhrII=;
        b=E0O8DIi7tw40iuG4trpS25Asp0piIr0YaPrg07TdKp/GXFm5AndkSh+jPLRrh43ExK
         ST/PX13DhZHDaQjIKPbUL/WhIkBl5VRubcyxY14Ny+Bw91lXXf9bVc6igiVQBif+9d3h
         jRML0x1yt59HKcBXr7zk8gCKOizZ853rOeiu22kWXZtDTmN2fs5/qFTGtmMNVhyZq+CD
         QUTol0VXsQ1NDudZhIbn7DjqQShW2WAE4+1aSt2WLajEAcGasUtfFhl5ocv1EYt8Jywh
         /14uSvjNoAzX9tBBoajEBdfKndb/UmCT41potgBQuM8uFFAEARdtWET4Ky6CuwzIO128
         W7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781548682; x=1782153482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7QL5zCyb7DMb7x/3/dZnW21sfO/tt0T7dScZLGhrII=;
        b=gkZvEP4WZe3nEG6sVFOSias1ncCLMhcYobtfDHwKA0OkazazpaA/xuCVFRh5UnLHzn
         ZZkIiNvtRH7CeNt2iIspS+PwT9+yHT/PdMDdWQO7TWKKDi18+qCiChD+lPUyxf5A9iOe
         mXFaSfG0BaR6u4joKosFJ/Ei04bDbjtPuaUTsEIAkXFuQWpDTwkn2+MC6UO7kNP0xSme
         zeDNaky73PApqJ9E5BNl2sAac6rLEgHNWyYPxHnqjLN6cs40cfE0ig1Wv14/Eeq/8NjI
         JLQkKDslHihNcfhNbg3+brdRSFzIQAaNTd9AK+fwcrzuoefrsntdyLFevIh9uTCJhvRi
         NTJg==
X-Forwarded-Encrypted: i=1; AFNElJ/2saR0LpmB+I9PAIwulBxmJWDG/IkwRS+CeBXFL8j52J4bbjsO8xFpz4Fka9Fx3No6NImcT7sKXcl48efGfOru@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOOggXmklti+u3CHSmu5f3qwoLCvilQkl4C1Wt9toLB4X3Wpy
	o99RvaEB0dRPY3SyFeaUzWXDeRj9QauSMsf2LDeQn1vhjFxf5JOsu9WHJwr6gamtip7rPncoLM6
	dJMjE6agIO4fcTqoYeluIHEVv2J/RSZaDdvhloDdn
X-Gm-Gg: Acq92OGpSIOeXdCC53qWjJH3iEKVZfUvD4cFNDKcYCGCdeXuqYprJjBv5Sepgm/+WLk
	XL22UhCUCansHlBPey0bCxQ/98hqfPGPSBe0nN7uNmsSMkEJrgbsWY00X0keNESlADIy+YK0kAN
	fEFnXOlswVtiec31hICs657iRsKD5seIT/FWffOzpPclGFR1SmD85Om2XGQ/dgGbFYJ2pItGYhl
	jYfoStHVjmhXrvIZoyZ1kc2zRYLKDAus7eKhP87enpDXg6guyEeZMPJVJ3R5JP7EpUmCc6s77uj
	wMIOnIg31IV9K2hAabvIYaLx/IW1SH1EbT7S
X-Received: by 2002:a17:902:cf0b:b0:2c1:4a67:5f31 with SMTP id
 d9443c01a7336-2c69a332b89mr300815ad.9.1781548681828; Mon, 15 Jun 2026
 11:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 11:37:50 -0700
X-Gm-Features: AVVi8CcJ4zfHqLnXlWL_DNOYvBaojBGVRBvebcDAS5aKd5XfBSTcn4XWZqQQ6xw
Message-ID: <CAP-5=fVrJg9YZE7k_ZhGOsjtHXvfqbz2Yw74YC+DcW0Hn0gFAA@mail.gmail.com>
Subject: Re: [Patch v3] perf tests: Add auto counter reload (ACR) sampling test
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 9:59=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Add auto counter reload sampling test to verify that the intended event
> records can be captured and the self-reloaded events won't generate any
> records.
>
> Additionally, enhance ratio_to_prev test to verify ACR sampling as well
> if ACR is supported.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> V3: Move ratio-to-prev ACR sampling test into ratio_to_prev test.
> V2: https://lore.kernel.org/all/20260420025501.2133495-1-dapeng1.mi@linux=
.intel.com/
> v1: https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.=
intel.com/
>
>  tools/perf/tests/shell/record.sh | 92 +++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 7cb81cf3444a..091d8b0a998b 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -402,7 +402,52 @@ test_callgraph() {
>    echo "Callgraph test [Success]"
>  }
>
> +test_acr_sampling() {
> +  events=3D"{instructions/period=3D40000,acr_mask=3D0x2/u,cycles/period=
=3D20000,acr_mask=3D0x3/u}"
> +  pebs_events=3D"{instructions/period=3D40000,acr_mask=3D0x2/pu,cycles/p=
eriod=3D20000,acr_mask=3D0x3/u}"
> +  echo "Auto counter reload (ACR) sampling test"
> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/n=
ull
> +  then
> +    echo "Auto counter reload sampling [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
> +  then
> +    echo "Auto counter reload sampling [Failed missing instructions even=
t]"
> +    err=3D1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
> +  then
> +    echo "Auto counter reload sampling [Failed cycles event shouldn't be=
 sampled]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /=
dev/null
> +  then
> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
> +    echo "Auto counter reload sampling [Success]"
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
> +  then
> +    echo "Auto counter reload PEBS sampling [Failed missing instructions=
 event]"
> +    err=3D1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
> +  then
> +    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn=
't be sampled]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Auto counter reload sampling [Success]"
> +}
> +
>  test_ratio_to_prev() {
> +  ratio_events=3D"{instructions:u,cycles/period=3D20000,ratio-to-prev=3D=
0.5/u}"
> +  p_core_ratio_events=3D"{cpu_core/instructions/u,cpu_core/cycles,period=
=3D20000,ratio-to-prev=3D0.5/u}"
> +  e_core_ratio_events=3D"{cpu_atom/instructions/u,cpu_atom/cycles,period=
=3D20000,ratio-to-prev=3D0.5/u}"

Could there also be cpu_lowpower coverage? What about e-core or p-core
only devices?

Thanks,
Ian

>    echo "ratio-to-prev test"
>    if ! perf record -o /dev/null -e "{instructions, cycles/period=3D10000=
0,ratio-to-prev=3D0.5/}" \
>       true 2> /dev/null
> @@ -438,7 +483,51 @@ test_ratio_to_prev() {
>      err=3D1
>      return
>    fi
> -  echo "Basic ratio-to-prev record test [Success]"
> +
> +  ratio_err=3D0
> +  do_ratio_to_prev_test() {
> +    local events=3D$1
> +    local cpu=3D$2
> +    if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev=
/null
> +    then
> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed sa=
mpling]"
> +      ratio_err=3D1
> +      return
> +    fi
> +    if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
> +    then
> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed mi=
ssing instructions event]"
> +      ratio_err=3D1
> +      return
> +    fi
> +    if perf script -i "${perfdata}" -F event | grep -q "cycles"
> +    then
> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed cy=
cles event shouldn't be sampled]"
> +      ratio_err=3D1
> +      return
> +    fi
> +  }
> +
> +  # ratio-to-prev sampling would fallback to normal sampling if ACR samp=
ling
> +  # is not supported, so acr_mask must be checked before testing ratio-t=
o-prev sampling.
> +  if [ -e /sys/bus/event_source/devices/cpu/format/acr_mask ]
> +  then
> +    do_ratio_to_prev_test "${ratio_events}" ""
> +  fi
> +  if [ -e /sys/bus/event_source/devices/cpu_core/format/acr_mask ]
> +  then
> +    do_ratio_to_prev_test "${p_core_ratio_events}" "P-core"
> +  fi
> +  if [ -e /sys/bus/event_source/devices/cpu_atom/format/acr_mask ]
> +  then
> +    do_ratio_to_prev_test "${e_core_ratio_events}" "E-core"
> +  fi
> +  if test "$ratio_err" -eq 0
> +  then
> +    echo "Basic ratio-to-prev record test [Success]"
> +  else
> +    err=3D"${ratio_err}"
> +  fi
>  }
>
>  # raise the limit of file descriptors to minimum
> @@ -457,6 +546,7 @@ test_leader_sampling
>  test_topdown_leader_sampling
>  test_precise_max
>  test_callgraph
> +test_acr_sampling
>  test_ratio_to_prev
>
>  # restore the default value
> --
> 2.34.1
>
