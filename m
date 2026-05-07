Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552B358372
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170637; cv=pass; b=t+dSBujZt227WGN3lmOipifrfWS+ehFoemU8tdhqPbhlfacPfX6QtkxBHn00i7OJz9GFlHIaRFVdutssFl1u4QjdJjBZGMrPx0df4/VNhubzQJqUhJXmmdrX66lqy+ZrLizSpoy2nlaAWoI2Y4i5jJUwOfgrD/1wFkWO2JMxLqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170637; c=relaxed/simple;
	bh=VQX7MovtysURwzAd7derAelU8IVpbMXJ6HTlu5lfEFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soGEL7z5LPhuFRzB7Yv7iJOPJn4pMo6yDdDqT7FsYB6lozTJB4yzM5SOG9V1aBOGf0rR9m3OmuJS8DRJtpNGXaNabr8E+hBo0fawLp1Q+H37TW9WSPdize9Yc2mZ6Um2qKBJxMC/H/xzR8ZKRYupia5nkPQw3s2jrYh1nFOmJpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4r6y0e/; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4r6y0e/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so106495ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 09:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778170635; cv=none;
        d=google.com; s=arc-20240605;
        b=ineLQ9slfjJElV1baGzCI4+eZBElpsPvQjNI7iQX8I7pCiZC9SHG3l9/Ex6SpHAY8J
         FkkGidgSOR8Lmkq3tbrpMx7TOYjEMmum95Yl1IwfPfTmTurpTZ6cXUhHrVTHlaZmDj8p
         QWyD08WiTOEVdcnhUZc9ohyrr7VqRDqwLnpUjTabTG0BZ0IjZSPeytFFljSur40lYO0e
         fgtua8KZs58Ydw1LE8k07N4/5QgBrcFRLMnxcCxXjCmJibn5TVraWAai1wA4mBs5yQKA
         VRUuhJqg6bgo7Xt3O80Jmf7XDAagOQJp21lEGXU4bRxHWFy15jfQ4QhjcUNMOK2snvIl
         lh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qdqDoTdhmyn0kwH2MqjN7/vDEjgthZW4Kf8hgmsuZlc=;
        fh=WPivUcjSK+fNhwrzir/RP5v8gUM9dc0iJXiu3I+suM4=;
        b=Xw6Yoyf22srAWe7EuC7KOblyFUGzGR17je+mSwemTL6hxIU1s9Sz6Gna3HYVgRtk6g
         q175l7IZmTyD6vJqq0YeR5qb4yqJfPPHButTh7DYVyHcAMksizSOOF5qnndciU+CGl/g
         SdrM5T5hSUBZQ1aiuJ8+WfL5ERjU7MmZC7QIiqvFEm3pGL66qo2a5yitY2rP0vL670+Q
         lxhxNENpA7eHc5H52EUV5xLPZHMFLutnkZ7Q/9Ag6udJSvLmL8NLFEGWQ2YMRXlKELP0
         2goX4w6Wdap2hZ0DOG1XhG1rL6qPGYtD7JCEjtiaBW1XfYmnGWq0YBQT/Rq/hUHjx7lS
         ObkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778170635; x=1778775435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdqDoTdhmyn0kwH2MqjN7/vDEjgthZW4Kf8hgmsuZlc=;
        b=g4r6y0e/ub9nL97++nPBVZq3kM3uTAANiLLLcmVch8gKZj5ruaxK9pBWPDqRXxiL+k
         FNFDAp01KarHfQY2GMMLdd330Wk1f3HNSyhIEMdwF+q/VxkpDvdhu2f+VH0x2DiuvywS
         5sg2SjGPmT55+1LbyrvSditGWdQWAfgIL7PMvUO8ipoco+qsMkw2lHWsPfi7GKUe5vUy
         ccjVhJlNF2iukAYzKMesykMZfIQa6NnC1eE77aHMfOQP2P073a7QpDrdEnUiiSmVN9va
         RpeckaQDL0RC0Yt/0MHInmKtkUCNsHm0J1ALp8/DF0ZK57iDtielCQ45pKKeO7x+IkOo
         fcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170635; x=1778775435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdqDoTdhmyn0kwH2MqjN7/vDEjgthZW4Kf8hgmsuZlc=;
        b=LOZ5kZgpZugwTYcmBbiboLKttX6NdsJy8g7PGjCGh0EWOSB0oOEEd2nAlpqbx8wir6
         NZQfx/XD9NAe+ovKR7f6MEcKuOls2oRfn9ZckoVq8U1seUhXSqrmxCmdlXWtoPEtzzpi
         FYtvb9W4dB7qL6L6T5J5H8EOEVgzjuOQEOhfQw5g4m4sjtpcr9gPnUiEPbqfN11KMxML
         hyCKTI17SrI1YxkMC4EqYRhn05a03vLwqUIn1ENfsqX8UX+Y8nVH/ktqM0uVQKsT2wnr
         Q2uGYk5ae2vxaAF8ltNjaQYlz/zbC7/jnA1ttlTucHZWBHyp8/GABKwxrtcmWmn3F+Zn
         UDFg==
X-Forwarded-Encrypted: i=1; AFNElJ+41BOv5Pz4l368DBtSCrZrHxqk9yPTAWooUTrhopExSscikeB38E+UeznsiIgvA9zQmMp405OePWVGi7bkVBVL@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjpd8At682bdjkPE2mp/EF8X0RTD1bu4/PVQhD7T1z/cyVKrf
	nsaK/QDLQtLIhW/MA84AF2hoEEpJds+vBxIpL4t4gMT600IQlY1hkaAP6vGZUTztyy8suc8mBhj
	xQlXzC7i4yaC6Q2NQ/5ltyOrtaTMbUEPzCzGHrdRb
X-Gm-Gg: Acq92OHfZwfw6p/GD7qu43ZVcTK1uTdRopcsa9O4sK8bHRKRAujpej1CR1u/ARpnp56
	+icFXjWJ2HDVtC8u7ofeTJJ0AahvghM64+ugWP2XH/BS6x0/R8tUh7oHgK76zb69oivLEjZq+CJ
	Yeb8afn2bo4ygY3+Xt/791Tec+fvI9EKUPsJY4YElOpaYTbgtnZo0z/GOqqFSFnVnhJ7UhMzc0d
	LNryVojoQVrIFBh103GF4wK7PqW+iMlsYSyfbGsAIYInKC9UsgKUOdLqgnTf9Dp3oc12BBao5TI
	Kx9TC0Il128gI59GZCN0NDSd5oP9MxeKm8z2rX4kVB7XVACj
X-Received: by 2002:a17:902:e284:b0:2ae:4e8e:954e with SMTP id
 d9443c01a7336-2bae59d023fmr466465ad.5.1778170634127; Thu, 07 May 2026
 09:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504072937.2103453-1-irogers@google.com> <20260506004546.3140141-1-irogers@google.com>
 <20260506004546.3140141-6-irogers@google.com> <d0ac5850-91e8-489b-be02-322c7c35fd07@linaro.org>
In-Reply-To: <d0ac5850-91e8-489b-be02-322c7c35fd07@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 09:17:02 -0700
X-Gm-Features: AVHnY4IozdEgY9JGxo8z1oc2Wsbgc73Aytdc0QRJePUpZjoD82aYZMsPyMeI8lM
Message-ID: <CAP-5=fV6XfGSSnCwi1MEcEj5TA5H8SoFRrkP7zU9C17Y9L-Bnw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] perf test: Add inject ASLR test
To: James Clark <james.clark@linaro.org>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	acme@kernel.org, gmx@google.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 8:58=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 06/05/2026 1:45 am, Ian Rogers wrote:
> > Add a new shell test `inject_aslr.sh` to verify the `perf inject --aslr=
`
> > feature. The test covers:
> > - Basic address remapping for user space samples.
> > - Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
> > - Callchain address remapping.
> > - Consistency of `perf report` output before and after injection.
> > - Pipe mode report consistency.
> > - Dropping of samples that leak ASLR info (physical addresses).
> > - Kernel address remapping (skipping gracefully if permissions restrict
> >    recording the kernel map).
> > - Kernel report consistency with address normalization.
> >
> > The test suite is hardened with global 'set -o pipefail' assertions to =
catch
> > pipeline failures, stream-consuming awk processors to handle SIGPIPE si=
gnals,
> > and a dedicated pipe output scenario validating raw 'perf inject -o -' =
stdout
> > streams.
> >
> > Assisted-by: Gemini-CLI:Google Gemini 3
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v5: Harden test suite verification pipelines by upgrading report checks=
 to
> >      strict sorted line-by-line diff comparisons to accommodate remappe=
d pointer
> >      shifts. Append || true fallback operators to grep-v filtering pipe=
lines to
> >      prevent the shell test from spuriously aborting under set -o pipef=
ail on
> >      empty inputs, ensuring graceful failure checks trigger correctly.
> > v4: Reorder set -e/pipefail to prevent temp file leakage in root direct=
ory on
> >      unprivileged record failures when run as root. Ensure grep report =
filters
> >      have || true suffixes to avoid aborts under pipefail. Add comprehe=
nsive
> >      pipe stdout injection attributes validation case.
> > v3: Harden script with pipefail, SIGPIPE awk pipeline fixes, callchain =
empty
> >      data asserts, baseline sample verification, and grep report abort
> >      protections. Reorder set -e/pipefail to prevent stack leaks in mkt=
emp
> >      failures.
> > v2: Add sum comparison for kernel overhead and 32-bit math corrections.=
 Add
> >      awk with gsub for trailing dots and brackets normalizations. Trap =
EXIT,
> >      prevent race conditions and avoid hardcoded perf binary.
> > ---
> >   tools/perf/tests/shell/inject_aslr.sh | 459 +++++++++++++++++++++++++=
+
> >   1 file changed, 459 insertions(+)
> >   create mode 100755 tools/perf/tests/shell/inject_aslr.sh
> >
> > diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/s=
hell/inject_aslr.sh
> > new file mode 100755
> > index 000000000000..cdc3aa94de63
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/inject_aslr.sh
> > @@ -0,0 +1,459 @@
> > +#!/bin/bash
> > +# perf inject --aslr test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +set -o pipefail
> > +
> > +shelldir=3D$(dirname "$0")
> > +# shellcheck source=3Dlib/perf_has_symbol.sh
> > +. "${shelldir}"/lib/perf_has_symbol.sh
> > +
> > +sym=3D"noploop"
> > +
> > +skip_test_missing_symbol ${sym}
> > +
> > +# Create global temp directory
> > +temp_dir=3D$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
> > +data=3D"${temp_dir}/perf.data"
> > +data2=3D"${temp_dir}/perf.data2"
> > +
> > +prog=3D"perf test -w noploop"
> > +[ "$(uname -m)" =3D "s390x" ] && prog=3D"$prog 3"
> > +err=3D0
> > +
> > +
> > +
> > +cleanup() {
> > +  # Check if temp_dir is set and looks sane before removing
> > +  if [[ "${temp_dir}" =3D~ ^/tmp/perf-test-aslr\. ]]; then
> > +    rm -rf "${temp_dir}"
> > +  fi
> > +}
> > +
> > +trap_cleanup() {
> > +  cleanup
> > +  exit 1
> > +}
> > +
> > +trap cleanup EXIT
> > +trap trap_cleanup TERM INT
> > +
> > +get_noploop_addr() {
> > +  local file=3D$1
> > +  perf script -i "$file" | awk '
> > +    BEGIN { found=3D0 }
> > +    {
> > +      for (i=3D1; i<=3DNF; i++) {
> > +        if ($i ~ /noploop\+/) {
> > +          if (!found) {
> > +            print $(i-1)
> > +            found=3D1
> > +          }
> > +        }
> > +      }
> > +    }'
> > +}
> > +
> > +test_basic_aslr() {
> > +  echo "Test basic ASLR remapping"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.basic.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.basic.XXXXXX")
> > +
> > +  perf record -e task-clock:u -o "${data}" ${prog}
> > +  perf inject -v --aslr -i "${data}" -o "${data2}"
> > +
> > +  orig_addr=3D$(get_noploop_addr "${data}")
> > +  new_addr=3D$(get_noploop_addr "${data2}")
> > +
> > +  echo "Basic ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Basic ASLR test [Failed - no noploop samples in original fil=
e]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Basic ASLR test [Failed - could not find remapped address]"
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Basic ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    echo "Basic ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_pipe_aslr() {
> > +  echo "Test pipe mode ASLR remapping"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.pipe.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.pipe.XXXXXX")
> > +
> > +  # Use tee to save the original pipe data for comparison
> > +  perf record -e task-clock:u -o - ${prog} | tee "${data}" | perf inje=
ct --aslr -o "${data2}"
> > +
> > +  orig_addr=3D$(get_noploop_addr "${data}")
> > +  new_addr=3D$(get_noploop_addr "${data2}")
> > +
> > +  echo "Pipe ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Pipe ASLR test [Failed - no noploop samples in original file=
]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Pipe ASLR test [Failed - could not find remapped address]"
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Pipe ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    echo "Pipe ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_callchain_aslr() {
> > +  echo "Test Callchain ASLR remapping"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.callchain.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.callchain.XXXXXX")
> > +
> > +  perf record -g -e task-clock:u -o "${data}" ${prog}
> > +  perf inject --aslr -i "${data}" -o "${data2}"
> > +
> > +  orig_addr=3D$(get_noploop_addr "${data}")
> > +  new_addr=3D$(get_noploop_addr "${data2}")
> > +
> > +  echo "Callchain ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Callchain ASLR test [Failed - no noploop samples in original=
 file]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Callchain ASLR test [Failed - could not find remapped addres=
s]"
>
> Hi Ian,
>
> This test fails on Arm. I believe it's because on Arm we request the
> link register to be sampled with frame pointer unwinds. Then the aslr
> tool drops all the samples because it sees that user regs were sampled:
>
>    /* TODO: can this be less conservative? */
>    pr_debug("Dropping regs user sample as possible ASLR leak\n");
>    ret =3D 0;
>    goto out_put;
>
> I think maybe that comment is onto something. Perhaps the user regs can
> be zeroed instead of dropping the sample. Then the frame pointer unwind
> will still work on Arm and the aslr test will pass. We just won't be
> able to use the link register to add the leaf frame caller, but that's
> not a big deal.

Thanks James. I'm working on a new version of the patches, but I'm
having delays getting the AI to approve the changes.

ARM does what? Ah, I knew this and also it didn't really register. I'm
wondering now if we can put the machinery behind "EM_HOST =3D=3D
EM_AARCH64":
https://lore.kernel.org/all/20211217154521.80603-2-german.gomez@arm.com/
as it seems a mechanism that would benefit other architectures such as
ARM32 :-) And I have my mission to make tools/perf/arch disappear as
much as is humanly possible.
I also imagine the problem the link register solves for perf happens
for BPF, so perhaps this ability shouldn't be encouraged.

I think rather than zeroing the register values it would be better to
just remove them from the output events. I'll try to add that support
as having this test break on ARM isn't desirable.

Thanks,
Ian

> James
>
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Callchain ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    # Extract callchain addresses (indented lines starting with hex ad=
dresses)
> > +    orig_callchain=3D$(perf script -i "${data}" | awk '/^[[:space:]]+[=
0-9a-f]+/ {print $1}')
> > +    new_callchain=3D$(perf script -i "${data2}" | awk '/^[[:space:]]+[=
0-9a-f]+/ {print $1}')
> > +
> > +    if [ -z "$orig_callchain" ]; then
> > +      echo "Callchain ASLR test [Failed - no callchain samples in orig=
inal file]"
> > +      err=3D1
> > +    elif [ -z "$new_callchain" ]; then
> > +      echo "Callchain ASLR test [Failed - callchain data was dropped]"
> > +      err=3D1
> > +    elif [ "$orig_callchain" =3D "$new_callchain" ]; then
> > +      echo "Callchain ASLR test [Failed - callchain addresses were not=
 remapped]"
> > +      err=3D1
> > +    else
> > +      echo "Callchain ASLR test [Success]"
> > +    fi
> > +  fi
> > +}
> > +
> > +test_report_aslr() {
> > +  echo "Test perf report consistency"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +
> > +  perf record -e task-clock:u -o "${data}" ${prog}
> > +  # Use -b to inject build-ids and force ordered events processing in =
both
> > +  perf inject -b -i "${data}" -o "${data_clean}"
> > +  perf inject -v -b --aslr -i "${data}" -o "${data2}"
> > +
> > +  local report1=3D"${temp_dir}/report1"
> > +  local report2=3D"${temp_dir}/report2"
> > +  local report1_clean=3D"${temp_dir}/report1.clean"
> > +  local report2_clean=3D"${temp_dir}/report2.clean"
> > +  local diff_file=3D"${temp_dir}/diff"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf report -i "${data2}" --stdio > "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || =
true
> > +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || =
true
> > +
> > +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" ||=
 true
> > +
> > +  if [ ! -s "${report1_clean}" ]; then
> > +    echo "Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_pipe_report_aslr() {
> > +  echo "Test pipe mode perf report consistency"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.pipe_report.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.pipe_report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +
> > +  # Use tee to save the original pipe data, then process it with injec=
t -b
> > +  perf record -e task-clock:u -o - ${prog} | \
> > +    tee "${data}" | \
> > +    perf inject -b --aslr -o "${data2}"
> > +  perf inject -b -i "${data}" -o "${data_clean}"
> > +
> > +  local report1=3D"${temp_dir}/report1"
> > +  local report2=3D"${temp_dir}/report2"
> > +  local report1_clean=3D"${temp_dir}/report1.clean"
> > +  local report2_clean=3D"${temp_dir}/report2.clean"
> > +  local diff_file=3D"${temp_dir}/diff"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf report -i "${data2}" --stdio > "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || =
true
> > +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || =
true
> > +
> > +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" ||=
 true
> > +
> > +  if [ ! -s "${report1_clean}" ]; then
> > +    echo "Pipe Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Pipe Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Pipe Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_pipe_out_report_aslr() {
> > +  echo "Test pipe output mode perf report consistency"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.pipe_out_report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +
> > +  perf record -e task-clock:u -o "${data}" ${prog}
> > +  perf inject -b -i "${data}" -o "${data_clean}"
> > +
> > +  local report1=3D"${temp_dir}/report1"
> > +  local report2=3D"${temp_dir}/report2"
> > +  local report1_clean=3D"${temp_dir}/report1.clean"
> > +  local report2_clean=3D"${temp_dir}/report2.clean"
> > +  local diff_file=3D"${temp_dir}/diff"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio >=
 "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || =
true
> > +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || =
true
> > +
> > +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" ||=
 true
> > +
> > +  if [ ! -s "${report1_clean}" ]; then
> > +    echo "Pipe Output Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Pipe Output Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Pipe Output Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_dropped_samples() {
> > +  echo "Test dropped samples (phys-data)"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.dropped.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.dropped.XXXXXX")
> > +
> > +  # Check if --phys-data is supported by recording a short run
> > +  if ! perf record -e task-clock:u --phys-data -o "${data}" -- sleep 0=
.1 > /dev/null 2>&1; then
> > +    echo "Skipping dropped samples test as --phys-data is not supporte=
d"
> > +    return
> > +  fi
> > +
> > +  perf record -e task-clock:u --phys-data -o "${data}" ${prog}
> > +  perf inject --aslr -i "${data}" -o "${data2}"
> > +
> > +  # Verify that the original file actually contained samples!
> > +  orig_samples=3D$(perf script -i "${data}" | wc -l)
> > +  if [ "$orig_samples" -eq 0 ]; then
> > +    echo "Dropped samples test [Failed - no samples in original file]"
> > +    err=3D1
> > +  else
> > +    # Verify that samples are dropped.
> > +    samples_count=3D$(perf script -i "${data2}" | wc -l)
> > +
> > +    if [ "$samples_count" -gt 0 ]; then
> > +      echo "Dropped samples test [Failed - samples were not dropped]"
> > +      err=3D1
> > +    else
> > +      echo "Dropped samples test [Success]"
> > +    fi
> > +  fi
> > +}
> > +
> > +test_kernel_aslr() {
> > +  echo "Test kernel ASLR remapping"
> > +  local kdata
> > +  kdata=3D$(mktemp "${temp_dir}/perf.data.kernel.XXXXXX")
> > +  local kdata2
> > +  kdata2=3D$(mktemp "${temp_dir}/perf.data2.kernel.XXXXXX")
> > +  local log_file
> > +  log_file=3D$(mktemp "${temp_dir}/kernel_record.log.XXXXXX")
> > +
> > +  # Try to record kernel samples
> > +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file=
}" 2>&1; then
> > +    echo "Skipping kernel ASLR test as recording failed (maybe no perm=
issions)"
> > +    return
> > +  fi
> > +
> > +  # Check for warning about kernel map restriction
> > +  if grep -q "Couldn't record kernel reference relocation symbol" "${l=
og_file}"; then
> > +    echo "Skipping kernel ASLR test as kernel map could not be recorde=
d (permissions restricted)"
> > +    return
> > +  fi
> > +
> > +  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
> > +
> > +  # Check if kernel addresses are remapped.
> > +  # Find the field that ends with :k: (the event name) and take the ne=
xt field!
> > +  orig_addr=3D$(perf script -i "${kdata}" | awk '
> > +    BEGIN { found=3D0 }
> > +    {
> > +      for (i=3D1; i<NF; i++) {
> > +        if ($i ~ /:[k]+:?$/) {
> > +          if (!found) {
> > +            print $(i+1)
> > +            found=3D1
> > +          }
> > +        }
> > +      }
> > +    }')
> > +  new_addr=3D$(perf script -i "${kdata2}" | awk '
> > +    BEGIN { found=3D0 }
> > +    {
> > +      for (i=3D1; i<NF; i++) {
> > +        if ($i ~ /:[k]+:?$/) {
> > +          if (!found) {
> > +            print $(i+1)
> > +            found=3D1
> > +          }
> > +        }
> > +      }
> > +    }')
> > +
> > +  echo "Kernel ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Kernel ASLR test [Failed - no kernel samples in original fil=
e]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Kernel ASLR test [Failed - could not find remapped address]"
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Kernel ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    echo "Kernel ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_kernel_report_aslr() {
> > +  echo "Test kernel perf report consistency"
> > +  local kdata
> > +  kdata=3D$(mktemp "${temp_dir}/perf.data.kernel_report.XXXXXX")
> > +  local kdata2
> > +  kdata2=3D$(mktemp "${temp_dir}/perf.data2.kernel_report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +  local log_file
> > +  log_file=3D$(mktemp "${temp_dir}/kernel_report_record.log.XXXXXX")
> > +
> > +  # Try to record kernel samples
> > +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file=
}" 2>&1; then
> > +    echo "Skipping kernel report test as recording failed (maybe no pe=
rmissions)"
> > +    return
> > +  fi
> > +
> > +  # Check for warning about kernel map restriction
> > +  if grep -q "Couldn't record kernel reference relocation symbol" "${l=
og_file}"; then
> > +    echo "Skipping kernel report test as kernel map could not be recor=
ded (permissions restricted)"
> > +    return
> > +  fi
> > +
> > +  # Use -b to inject build-ids and force ordered events processing in =
both
> > +  perf inject -b -i "${kdata}" -o "${data_clean}"
> > +  perf inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
> > +
> > +  local report1=3D"${temp_dir}/report_kernel1"
> > +  local report2=3D"${temp_dir}/report_kernel2"
> > +  local report1_clean=3D"${temp_dir}/report_kernel1.clean"
> > +  local report2_clean=3D"${temp_dir}/report_kernel2.clean"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf report -i "${kdata2}" --stdio > "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
> > +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
> > +
> > +  # Normalize kernel DSOs and addresses in clean reports
> > +  # This allows kernel modules to be either a module or kernel.kallsym=
s
> > +  local report1_norm=3D"${temp_dir}/report_kernel1.norm"
> > +  local report2_norm=3D"${temp_dir}/report_kernel2.norm"
> > +  local diff_file=3D"${temp_dir}/diff_kernel"
> > +
> > +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report1_clean}" | \
> > +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]",=
 $0); print}' | sort > "${report1_norm}" || true
> > +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
> > +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]",=
 $0); print}' | sort > "${report2_norm}" || true
> > +
> > +  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" || t=
rue
> > +
> > +  if [ ! -s "${report1_norm}" ]; then
> > +    echo "Kernel Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Kernel Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Kernel Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_basic_aslr
> > +test_pipe_aslr
> > +test_callchain_aslr
> > +test_report_aslr
> > +test_pipe_report_aslr
> > +test_pipe_out_report_aslr
> > +test_dropped_samples
> > +test_kernel_aslr
> > +test_kernel_report_aslr
> > +
> > +cleanup
> > +exit $err
>
