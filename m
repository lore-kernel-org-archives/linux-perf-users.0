Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF62868B4
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779749201; cv=pass; b=OrjcZ7F/I5OH1ioRcl+F3zJspuWD4F2UoEjqiaLAf5BhHNDMi2a9zLqtSlx7Xcjfmu0XgQMuoC3Z02Y2u4DyxS6l1OYm6ihrJRLMhx/xTQKLnKhtFhbosxS6nUogNxUvUBCRM0LRXMWI1ElKnQXIDoDzZrkyo7g0mCIxThPit7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779749201; c=relaxed/simple;
	bh=qCeARISMQNqgqucvkUZ6Pl8vl1D0y/dfuh4LLRql3ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0LwKSIw88pggutWkzw3WiVi5Ilcj8/ceKMYRBWCJdq5RYgLD4fDQjh4GBD8eKdA0T2Ig9WsCV4hJY2KJSvZblBUL1Rdkf0Dk6E6AhNsvW+DmKgFoLjl7KXP9GjqH3qXihbp/KZ322fHA2qago5BHRzWVv+TNyvLKatj4PGzYvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VnBl0OCw; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VnBl0OCw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso195ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 15:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779749199; cv=none;
        d=google.com; s=arc-20240605;
        b=Lj3smP7nHhgOzl101V+pvtJH2mxNwsJigTkmczk2WEJMeAj1CWF/pwhbCrq18EzkQq
         COXEJulKr0LSapCxa177zQpUYZcGtNT7O17ZCtBH8kPUjZtruowpEma3dIlzND7DWDP2
         CrJ3hyyI3IZp/nc/LpiXUz6FUpUrNMBzigawTJyCPSotz4NylWi7jqTcq9129xif2qv7
         zGcabahjw5VjVW0VfVb6CHe/nP92GpqzDCqIZRR8rg+UPY755tTUk8IvAd1xZuDk9L/J
         14t+UtZdaPW3a/9iukomDh3Iwz+SRwwj+TMt8Sqlm6Jl36Wixqx3Ia7Lphd3WmWvr48I
         3hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3M6LhySqjlJSwCUShMZOo5COjOLvN9Jov0qI/Oj5cE=;
        fh=8ofzPxj5k6T0Hvao44uuK28QlZcK5AFNd7RZLwsVC4s=;
        b=PDjWJF3qf72XkFItsIHirfJv51+qfxAdhxZnkO0/29brWW/A0t6XdsR1d/4d74R3wA
         C4MkmtI5DqDZBamapW+nKXDSFe0gTwQM7AWSz0IHgpagkvCiOwHcFCx4CgLV785ZA+m+
         kWCSwp3Uh+bd6dhFBGufB2sLAb5brizzHzhH1ydQsczTH25SiwrHBlHCiFtRkYy23B+y
         aLCyJyjp/KM6Lq6Zh9JIuIKJtUBgFZIEuDEuD/6RcMjbrjWn3hkbW8qHncIh7DBjhW5i
         UmJienFRa7UMOLejLMzl7NZxJ2VHA8BGFfvPkLvPi/QlX1+iHSi2ojsKchTyJLHWyjb9
         P5ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779749199; x=1780353999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3M6LhySqjlJSwCUShMZOo5COjOLvN9Jov0qI/Oj5cE=;
        b=VnBl0OCwfBQ96W2FfE84boBQ6H8EBkCmqgfJbwL7gUYrwFah41GL74QdFPCFkCvcwv
         3D0aEBcoIEhol0Hr08NMAIshIf/H4aPV40RnbXCTiW7wTIrRRYX2ho9gDJm/v0yj+7UR
         IKq7ybhoAqSlLv0rT4RS0J7Yfwt8GoU88NKNR27E/wMqoHGZlJ8wx7n99sCc5p69hdfK
         QcMUIGz+FbUty8iU4idqnhIU6s7xVffQJQrKicYYP0cXiO5XuVAkOQFhBoZD4n39lfSB
         2iULBm5zm02GtftFfAHj+VEGSzOchf91XKv3tOOVVaLNMnhOd0/im+5ffr4ZpCLkhIJJ
         BUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779749199; x=1780353999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3M6LhySqjlJSwCUShMZOo5COjOLvN9Jov0qI/Oj5cE=;
        b=GSVB96CCs43NAIgQQ5kp00aT0t5pGsb/QP6vyNlQl9i2WIObTRtOQfx05UqC7IP8U0
         Yxi8e5O9tf83DSVQqphVyZCJZC1FjcMXUoT1/FZbVn3fhMbdWNy6FaomVB6f5N1ug1m+
         wrE8mbdAvBZoQFRxjn4R1vrEAYPYNn5HhnSJ/Rgc4UJlqmHZz4WjY+bJb56MbrBC4r5h
         thAddo/3uYPwVvfQMwTUpdJPx4PXXUyFooBFys9P5n9FCMUBFrECvRS7b6KMnI067xhc
         VZhKvw7IftrtuX82Y8ami51PO+9tOTHWzWrPJkkTUfkwGukKBNTUpyKNhCh1swtB7kX+
         ZNyg==
X-Forwarded-Encrypted: i=1; AFNElJ8MwgnZFQVvDdIubPugL3L9EUJ8lHzu0yfvnr2aHinnB23OJOLANti86ejLp/vLkiwTqYXwxexAcf7s2nnQNdS8@vger.kernel.org
X-Gm-Message-State: AOJu0YwkD4U7K0wDSK0wZ86SEq50fwo7SIS7oeopUz5yE/UoevRJs6xf
	qP1dH20o75rc8FQ5ul/z+zjbAEQXzrSCL6eAb8GsY1pGVNoJWoelUw0aHI9Ou00j8jaTh0fjAZs
	zjltd/OB0EBfmAUzmfArkyYEAXKNcMItIdPz4A2pT
X-Gm-Gg: Acq92OGs3SZ3qx9nlRd1C3zUcpRc8kUuapIEMqv8xs868vtQ5TifKY67RKPohpEy3iJ
	f4F65uUMLsxV4RFzuq9lgZkme/sXnFoXZPB2/1ZMLClTnH8ufpiY2JoQ09PAPzM2SE08GagORsl
	HpBOe7NEP0s8jcqj3qaAI6SV9b+99OIcIXVIivJSUDDlvMgiXj7H0pe8+h4sHwjQyppeS0S2DSP
	A79y4xS8L0npgWYgfdy4FOfU1A7oUM+9rQrW7wrWSSX0jYyaLNGNrTBGypWHwRsXui03l+r6Yo8
	R1JXa7Eu61gr6Rhcnrs=
X-Received: by 2002:a17:903:9ce:b0:2bd:9e75:9e98 with SMTP id
 d9443c01a7336-2bec11c1885mr3261225ad.9.1779749198700; Mon, 25 May 2026
 15:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519015108.3094513-1-irogers@google.com> <20260519050150.3144907-1-irogers@google.com>
 <20260519050150.3144907-3-irogers@google.com> <agv7MMF7AEc_mdCN@z2>
 <CAP-5=fW14n=Po5fOv7nOTUoz2_W0uxU34h5V4uGX2agKqiLT9A@mail.gmail.com>
 <agyZZdFQqedToej1@google.com> <ahSn58YTobyDYr_4@x1>
In-Reply-To: <ahSn58YTobyDYr_4@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 15:46:27 -0700
X-Gm-Features: AVHnY4J3wU8AwpNvhFqtJlNoMalxzwfC9ZW1-tcfgNcvSaMiozm8zJhrcU1NCeU
Message-ID: <CAP-5=fWFw=Laf63bGt-BgWGSM6HwtpcxV++Q3Q6R8KfL0BSVzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf test: Add stat metrics --for-each-cgroup test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	skanev@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 12:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, May 19, 2026 at 10:09:57AM -0700, Namhyung Kim wrote:
> > On Tue, May 19, 2026 at 08:13:02AM -0700, Ian Rogers wrote:
> > > On Mon, May 18, 2026 at 10:54=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > On Mon, May 18, 2026 at 10:01:50PM -0700, Ian Rogers wrote:
> > > > > +             # Parse each metric line
> > > > > +             while read -r line; do
> > > > > +                     [ -z "${line}" ] && continue
> > > > > +
> > > > > +                     local cycles_val
> > > > > +                     cycles_val=3D$(echo "${line}" | cut -d, -f1=
)
> > > > > +
> > > > > +                     local event_name
> > > > > +                     event_name=3D$(echo "${line}" | cut -d, -f3=
)
> > > > > +
> > > > > +                     # Find corresponding instructions event lin=
e
> > > > > +                     local inst_event_name
> > > > > +                     inst_event_name=3D"${event_name/cpu-cycles/=
instructions}"
> > > > > +                     inst_event_name=3D"${inst_event_name/cycles=
/instructions}"
> > > > > +
> > > > > +                     local inst_line
> > > > > +                     inst_line=3D$(echo "${output}" | \
> > > > > +                             grep -F ",${cgrp}," | \
> > > > > +                             grep -F "${inst_event_name}" || tru=
e)
> > > > > +
> > > > > +                     local inst_val
> > > > > +                     inst_val=3D$(echo "${inst_line}" | cut -d, =
-f1)
> > > > > +
> > > > > +                     log_verbose "Cgroup '${cgrp}': event '${eve=
nt_name}' \
> > > > > +val '${cycles_val}', inst event '${inst_event_name}' val '${inst=
_val}'"
>
> > > > Why not make log_verbose() take multiple arguments and align them
> > > > properly?  Maybe you can just use 'echo'?  The same goes to the bel=
ow
> > > > lines.
>
> > > This fixes checkpatch warnings on line length and the odd alignment
> > > avoids spaces appearing in the output.
>
> > How about this?
>
> Ian posted a v4, are you ok with that now, Tested-by or Reviewed-by?

I can add the log_verbose change Namhyung asked for.

Thanks,
Ian

> - Arnaldo
>
> > Thanks,
> > Namhyung
> >
> >
> > diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/t=
ests/shell/stat_metrics_cgrp.sh
> > index d4226ee0ae9801cb..ecb2c053ea5158d4 100755
> > --- a/tools/perf/tests/shell/stat_metrics_cgrp.sh
> > +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> > @@ -7,7 +7,7 @@ set -e
> >  test_cgroups=3D
> >
> >  log_verbose() {
> > -     echo "$1"
> > +     echo "$*"
> >  }
> >
> >  is_numeric_and_non_zero() {
> > @@ -145,22 +145,22 @@ check_metric_reported()
> >                               cycles_val=3D$(echo "${cycles_line}" | cu=
t -d, -f1)
> >                       fi
> >
> > -                     log_verbose "Cgroup '${cgrp}': event '${event_nam=
e}' \
> > -val '${cycles_val}', inst val '${inst_val}'"
> > +                     log_verbose "Cgroup '${cgrp}': event '${event_nam=
e}'" \
> > +                                 "val '${cycles_val}', inst val '${ins=
t_val}'"
> >
> >                       # Only enforce metric check if both cycles and
> >                       # instructions have non-zero numeric counts
> >                       if is_numeric_and_non_zero "${cycles_val}" && \
> >                          is_numeric_and_non_zero "${inst_val}"
> >                       then
> > -                             log_verbose "Enforcing metric check for c=
group '${cgrp}' \
> > -event '${event_name}'"
> > +                             log_verbose "Enforcing metric check for c=
group '${cgrp}'" \
> > +                                         "event '${event_name}'"
> >                               # Check for nan or nested in the metric v=
alue (7th field)
> >                               # Actually we can just check the whole li=
ne for simplicity
> >                               if echo "${line}" | grep -q -i -E ",nan,|=
,nested,"
> >                               then
> > -                                     echo "FAIL: Invalid metric value =
(nan/nested) \
> > -for cgroup '${cgrp}'"
> > +                                     echo "FAIL: Invalid metric value =
(nan/nested)" \
> > +                                          "for cgroup '${cgrp}'"
> >                                       echo "Line: ${line}"
> >                                       exit 1
> >                               fi
> > @@ -173,8 +173,8 @@ for cgroup '${cgrp}'"
> >                                       exit 1
> >                               fi
> >                       else
> > -                             log_verbose "Skipping metric check for cg=
roup '${cgrp}' \
> > -event '${event_name}' (idle or not counted)"
> > +                             log_verbose "Skipping metric check for cg=
roup '${cgrp}'" \
> > +                                         "event '${event_name}' (idle =
or not counted)"
> >                       fi
> >               done <<< "${cgrp_lines}"
> >       done
