Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A6440D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 04:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIa6BiOV"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE012A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 21:14:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso1208e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698293658; x=1698898458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu+cJ2A5jegJ1aAww9qXUxmVyqtHTxWWbv9t7cZkvpc=;
        b=bIa6BiOV56KgnSfUwDg7KJUzG92uqJSPw00crvEfmra3XZb2NX0o+xEIF2hHaSm8q9
         nNa6SgCRcEZCy6gF/kL+bsffS/amgTzMSBTuoixA4/q0pwiUlzN4DBWEF4KdDtAtengu
         1aVmrmVTWEd1cy2/VxQZEeKgqKWAHve53yCsFcbL0o15n3ByIxYFiukI+YKOQjV/XHZ8
         4cYBSh7FrwBF2rVRCWpQ0fmXXomxx2hqcdeGw6vS+h5+HnAvgKgnimXWYrzoj09WwXkj
         q6pE2/Qey23jirI4NgW9vXS+oC1BKXD25ugkyaJMObxYttlP+FnDqf/iyf9DGkl3nrlS
         fUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698293658; x=1698898458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mu+cJ2A5jegJ1aAww9qXUxmVyqtHTxWWbv9t7cZkvpc=;
        b=r4ET6jRS2zoWoHco/14ajeN1l7cJvWNA8VyUBBrrWLfihXZr65S/i+F1aJHYUhym+7
         LPL8USCk2I+w3GjLhBVYbq1akinTzsUHuAbeaY2d0GCWi8gfBWIsRFofBoMzkANIr1JK
         MI5zzF72eVEcsQUeK4e9zFW2b5EMMUyVOqPVL1ltoj7MYmhgImJA4sEd0Ndv49GzsU6J
         pOSYUfZpOB/7cB1Wrkg6DUPLsXy983i34XxBb+VZI2lZkEVuJ/8Jt/YjiWgZ5ANtUFK4
         F6B+fu4t0YpLu9/hzT3K22B6rR8B3FGn0iDRvgaOCXT+bscFPGl/oQU7OLAkAqdv3n1E
         8zig==
X-Gm-Message-State: AOJu0YxoVSdEe9O/xhWPBJ0Y0AwDCIdCZAmRJww+ojnMLyQwi0EHdkMf
	TRtWRq7v3UCy6LJ87dZu/Fr5rVIUV3D2pFNg9CY1Bg==
X-Google-Smtp-Source: AGHT+IFLWApW19cgw/RvTQjRIwgPdkCMr56N8rmyrWlea9J5MMu92fldscjN+2aFDzvwMUDPJYdoFKHDI+qIudaVgGA=
X-Received: by 2002:ac2:5e6b:0:b0:507:9a37:1483 with SMTP id
 a11-20020ac25e6b000000b005079a371483mr113151lfr.3.1698293658094; Wed, 25 Oct
 2023 21:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023131550.487760-1-james.clark@arm.com>
In-Reply-To: <20231023131550.487760-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Oct 2023 21:14:05 -0700
Message-ID: <CAP-5=fW3k19j4aSGXBEzCE24c4+CvhLqA4MZ_F+etgtqjAWFug@mail.gmail.com>
Subject: Re: [PATCH] perf tests: test_arm_coresight: Simplify source iteration
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	suzuki.poulose@arm.com, atrajeev@linux.vnet.ibm.com, 
	tianruidong@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 6:17=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> There are two reasons to do this, firstly there is a shellcheck warning
> in cs_etm_dev_name(), which can be completely deleted. And secondly the
> current iteration method doesn't support systems with both ETE and ETM
> because it picks one or the other. There isn't a known system with this
> configuration, but it could happen in the future.
>
> Iterating over all the sources for each CPU can be done by going through
> /sys/bus/event_source/devices/cs_etm/cpu* and following the symlink back
> to the Coresight device in /sys/bus/coresight/devices. This will work
> whether the device is ETE, ETM or any future name, and is much simpler
> and doesn't require any hard coded version numbers
>
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> This was discussed here previously:
> https://lore.kernel.org/all/20230929041133.95355-2-atrajeev@linux.vnet.ib=
m.com/
>
> I chose not to add a fixes tag like the original because shellcheck
> isn't part of the build so it doesn't really fix any real issue yet and
> is just a refactor.
>
>  tools/perf/tests/shell/test_arm_coresight.sh | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/te=
sts/shell/test_arm_coresight.sh
> index fe78c4626e45..65dd85207125 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -11,19 +11,6 @@
>
>  glb_err=3D0
>
> -cs_etm_dev_name() {
> -       cs_etm_path=3D$(find  /sys/bus/event_source/devices/cs_etm/ -name=
 cpu* -print -quit)
> -       trcdevarch=3D$(cat ${cs_etm_path}/mgmt/trcdevarch)
> -       archhver=3D$((($trcdevarch >> 12) & 0xf))
> -       archpart=3D$(($trcdevarch & 0xfff))
> -
> -       if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" =3D "0xA13=
" ] ; then
> -               echo "ete"
> -       else
> -               echo "etm"
> -       fi
> -}
> -
>  skip_if_no_cs_etm_event() {
>         perf list | grep -q 'cs_etm//' && return 0
>
> @@ -149,7 +136,9 @@ arm_cs_iterate_devices() {
>
>  arm_cs_etm_traverse_path_test() {
>         # Iterate for every ETM device
> -       for dev in /sys/bus/coresight/devices/$(cs_etm_dev_name)*; do
> +       for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
> +               # Canonicalize the path
> +               dev=3D`readlink -f $dev`
>
>                 # Find the ETM device belonging to which CPU
>                 cpu=3D`cat $dev/cpu`
> --
> 2.34.1
>
