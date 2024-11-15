Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0819007E;
	Fri, 15 Nov 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663150; cv=none; b=ERDiq1/rNldPWAhoGUR2eymwfKIO1VGvpQXZOHMQZhfT7t9ZywXNjeqZqRR83pT0rq27W36Ubloa22MdR/0RIeXr0SCF2BMoGMFiDXadzjSXgnQ6zA+Z+VIy6NfF4p3gQCw7TD8XOK7EDDYihtdmhIGXBlyCwUoHi4SB2aVHobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663150; c=relaxed/simple;
	bh=UAbz8CMdEwdsY4hu1vq3Mwxyhx8kNG2hgvcjL3vRqZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5ujMSL2piCvJz3BQ31Ki9x6khrGYwtdhGMpTN0ToAVSt0WQjbMzzW8um9RhBD5Sb6sOZCsY202zeOW1FT5e1QOA/el4tPhqTwZsoS138BA6TsR8+oTVtmCoJNDCQtLchCXNOuMCZO1kLzAFpOlRxoDznW5+kCWWSeeCedcVWh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klg0YOUQ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klg0YOUQ"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e30eca40c44so1758558276.2;
        Fri, 15 Nov 2024 01:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731663147; x=1732267947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rHDnR4uEx2ttpJPxGJ1Im408AGrT6YXLxkQVCCuAqo=;
        b=klg0YOUQ56Z+fc4Z8PX4ywqITtzvIVBFTA8iSslt9+ZODvu2Qq41kWi815iUUNSdBi
         mzf7CRAnGo+HDdUQFT70wqtw6AVVD3QXwXGon1bgMhCASJOp2sgLa6fNUYffhuc5N+Uz
         H1O6F89MjyC+qxm5cI32dw7kGc4xjO6dprux2Qy+Vq9e4uoO9v/3e59IDKes9pzrxW2C
         4hWSppAmKPNxmOOjDFs829oZIsnaDXEuuOOPSj1MyBeWvIJfk+diSPGyx9ODuHFl+v65
         p6MnYGxJWKAPNlL+KzLIS6A18wOBpH3CyzBJgjugcsyv/La7sSC7GIrKEbP47fcoLpSG
         nZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731663147; x=1732267947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rHDnR4uEx2ttpJPxGJ1Im408AGrT6YXLxkQVCCuAqo=;
        b=Kg/ENIXAyW3YXGtctLv81q+xKrFfqubZpdhd9dqJPXMApyQVRCnaEivr0t5aO4G/f2
         twXeatJFUBD0cudv6itx2tbl9gGoEUvBOQgB/dqOfVq5/v3U8lh+8TUAzL85wwBT2e7m
         08zAAXJhGnrleYeAdoZHI2yayrNaewQ2frTNlXPOJqipkutSeVP5nRjH5DRotW9SVUC/
         pnib2/ox2kBGuZJ5ktS7TNk3cJxTbrzn0AhnF0hPhgsK6mWGp/vWiqDMcaEMOwo2SRAa
         ueEhktAhH4qOCSu9C5bcmZGdWVKRC2+Xd1DrSuw+kWLz13QJFz4qVaGEyuvh0OxARkni
         ff8w==
X-Forwarded-Encrypted: i=1; AJvYcCVIO6HhOnWYWLurr9lsDYl01ge3k2tkwm4IjFdvY9YCWTqeNwUQsosdwVk6nEfa2u6jLFQ1H9ie7PD0WURq25XhnA==@vger.kernel.org, AJvYcCWmwUbjIw8+iatr6mIr3696zBWfcOraNbWCTL8jBs9BMMoBKSd58+S1JKv+lY6ejhj9DPI7E0oPvUDFGj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUI4EPFAOS+C2mhfm0weUvlY/nSeUXN/Uwavk2WnCKYwVCP5kV
	OW9BkagRzjcILWfc/nnMWBuSgQACWPGkP2upW/IydtXKWZvQXPzt8UGKkgnJuskoVLftk1wYKKw
	cDEKwV9g8zn4BcHb5ZkXZQnZ/5C4=
X-Google-Smtp-Source: AGHT+IE0ZyglH87YnCq1/+8VbLQ2qQFkGHX86EvWl00SHlqreK4td6socZ+c5/IvptB7hOs6hty/JG/0Jlgw2OWlVnk=
X-Received: by 2002:a05:6902:2b01:b0:e33:14fa:2273 with SMTP id
 3f1490d57ef6-e3825d1bd86mr1959970276.5.1731663145668; Fri, 15 Nov 2024
 01:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzZpX5O053UsHmsV@x1>
In-Reply-To: <ZzZpX5O053UsHmsV@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 15 Nov 2024 01:32:15 -0800
Message-ID: <CAH0uvohi_8_itv+jDjCEvrprakhp5w7=GvWw+hJG4gTLwJQjog@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests shell trace_exit_race: Show what went
 wrong in verbose mode
To: arnaldo.melo@gmail.com
Cc: Benjamin Peterson <benjamin@engflow.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Thu, Nov 14, 2024 at 1:19=E2=80=AFPM <arnaldo.melo@gmail.com> wrote:
>
> This is in the tmp.perf-tools-next  branch at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>
> I'll later add another patch adding the --no-comm to the 'perf trace'
> command line and will adjust the regexp.
>
> - Arnaldo
>
> ---
>
> If it fails we need to check what was the reason, what were the lines
> that didn't match the expected format, so:
>
>   root@number:~# perf test -v "trace exit race"
>   --- start ---
>   test child forked, pid 2028724
>   Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ =
syscalls:sys_enter_exit_group\(\)$':
>        0.000 :2028750/2028750 syscalls:sys_enter_exit_group()

This output looks good but I got an empty grep -v:

perf $ ./perf test 110 -v
110: perf trace exit race                                            :
Running (1
--- start ---
test child forked, pid 3865874
Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+
syscalls:sys_enter_exit_group\(\)$':
---- end(-1) ----
110: perf trace exit race                                            : FAIL=
ED!

In temp file:
0.000 true/3867219 syscalls:sys_enter_exit_group()
0.000 true/3867221 syscalls:sys_enter_exit_group()
0.000 true/3867223 syscalls:sys_enter_exit_group()
0.000 true/3867226 syscalls:sys_enter_exit_group()
0.000 true/3867250 syscalls:sys_enter_exit_group()
0.000 true/3867252 syscalls:sys_enter_exit_group()
0.000 true/3867255 syscalls:sys_enter_exit_group()
0.000 true/3867257 syscalls:sys_enter_exit_group()
0.000 true/3867259 syscalls:sys_enter_exit_group()
0.000 true/3867262 syscalls:sys_enter_exit_group()

There are 10 lines of output which match the regex (I got the comm
instead of pid), but it still falls into error, and inverse regex got
nothing because they are all right.

>   ---- end(-1) ----
>   110: perf trace exit race                                            : =
FAILED!
>   root@number:~#
>
> In this case we're not resolving the process COMM for some reason and
> fallback to printing just the pid/tid, this will be fixed in a followup
> patch.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> To: Benjamin Peterson <benjamin@engflow.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/shell/trace_exit_race.sh | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests=
/shell/trace_exit_race.sh
> index 3cf2d71a5c3b9278..ce05d4e6e7133cd1 100755
> --- a/tools/perf/tests/shell/trace_exit_race.sh
> +++ b/tools/perf/tests/shell/trace_exit_race.sh
> @@ -11,11 +11,17 @@
>
>  skip_if_no_perf_trace || exit 2
>
> +if [ "$1" =3D "-v" ]; then
> +       verbose=3D"1"
> +fi
> +
> +regexp=3D" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\=
)$"
> +
>  trace_shutdown_race() {
>         for _ in $(seq 10); do
>                 perf trace -e syscalls:sys_enter_exit_group true 2>>$file
>         done
> -       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter=
_exit_group\(\)$' $file)" =3D "10" ]
> +       [ "$(grep -c -E '$regexp' $file)" =3D "10" ]

shouldn't this be
[ "$(grep -c -E "$regexp" $file)" =3D "10" ]
?

In shell script single quote doesn't interpolate, in this case you are
literally grepping the string "$regexp". After changing this to double
quotes it works for me.

>  }
>
>
> @@ -27,5 +33,11 @@ export PERF_CONFIG=3D/dev/null
>
>  trace_shutdown_race
>  err=3D$?
> +
> +if [ $err !=3D 0 ] && [ "${verbose}" =3D "1" ]; then
> +       echo "Lines not matching the expected regexp: '$regexp':"

Also, I think there is a case, where $err !=3D 0 can come from not
having 10 matches, say 4 (because of racing), and these 4 can all be
correct, the inverse grep -v won't match anything, results in an empty
output as above:

Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+
syscalls:sys_enter_exit_group\(\)$':
---- end(-1) ----

> +       grep -v -E "$regexp" $file
> +fi
> +
>  rm -f ${file}
>  exit $err
> --
> 2.47.0
>

Maybe this? (based on your test)

diff --git a/tools/perf/tests/shell/trace_exit_race.sh
b/tools/perf/tests/shell/trace_exit_race.sh
index ce05d4e6e713..3633907e9e2a 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -16,12 +16,15 @@ if [ "$1" =3D "-v" ]; then
 fi

 regexp=3D" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$=
"
+iter=3D15

 trace_shutdown_race() {
-        for _ in $(seq 10); do
+        for _ in $(seq $iter); do
                 perf trace -e syscalls:sys_enter_exit_group true 2>>$file
         done
-        [ "$(grep -c -E '$regexp' $file)" =3D "10" ]
+
+        result=3D"$(grep -c -E "$regexp" $file)"
+        [ $result  =3D $iter ]
 }


@@ -35,8 +38,12 @@ trace_shutdown_race
 err=3D$?

 if [ $err !=3D 0 ] && [ "${verbose}" =3D "1" ]; then
-        echo "Lines not matching the expected regexp: '$regexp':"
-        grep -v -E "$regexp" $file
+        if grep -q -v -E "$regexp" $file; then
+                echo "Lines not matching the expected regexp: '$regexp':"
+                grep -v -E "$regexp" $file
+        else
+                echo "Missing output, expected $iter but only got $result"
+        fi
 fi

 rm -f ${file}

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
