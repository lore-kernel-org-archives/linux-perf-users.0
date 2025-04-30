Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31171BD9F0
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054832; cv=none; b=XANwGUKnRdkYyT4211K+ETSMO7PvuCAr3q7TNYsNn/n55WkK1WJr7WsyHv7cv4IKMtJJw1cxcuP1w3FuaOLUuwRboBcrLroo8YWBVbVhywxXTlLbr9NCqeO8JKiIrGOpeSH4/arYIemuZzJiJJlh3P31Kz8vGrP+NZs1LEZkxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054832; c=relaxed/simple;
	bh=LBOzXCcKO0/ZtAF6DDfQbKrPQirjVnexU5H70cePBJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpkTZsVrfjAueOG1GvvKO4+B7oQpAdKCDZj31v4sghOGbAL8ZAcc61HqByWZv5k633VXf8aQextpHk9ABIikV35YASGITrzZCwYa3F4mygVzNB6FNnok1mrmrK5Bmbvj8sqKf+KME60wgSMli6B62oEKFAO+S6sNnCSKfA3n0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnUEa+eW; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnUEa+eW"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so5195ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746054830; x=1746659630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1+5RX45N4aC1aLrGMuC6PdSTtKGMNNWwxBii/MYMd4=;
        b=lnUEa+eW6oG9S50ErQ7v6bclGNwb7Qd6cGcl18a8/dvgxzhf50WFKFobiDDsUlGY0Y
         6nr5xfORSihmr73PIcSEUbI8ggLsr0KTaf80AqZNaxAuPMcN6nr7XCEjthqAABXNN+PK
         6a7nScHtVdo2Ge8w9TocrX8v9mXRLlQnprLm0jmnhtZsUItV5xNzw8mbxX3UKul8jIWt
         Txp3A8Js/YDQOlElhRmXFL2fz09ZCGD5r7dsljh9J4cWoXU/QTIxDdgAkVqH8+lonzfL
         YmfvTMihsHrCEHjE2bbiPuGMfxhmvX7Tcj8QufCM1peDMLf5xkEIfRLZsh1E/cYidZ+G
         mkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746054830; x=1746659630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1+5RX45N4aC1aLrGMuC6PdSTtKGMNNWwxBii/MYMd4=;
        b=m7FmND4eb5p1bQHC3XodYCcQVZ6t5EcQV8Ll15fsAyMRHFwTR3bA+kpdSUe/ZBV3jB
         f6mv3cB4VkTZQnfJjDN70h9LT3JFZWmaOQMT3bpfnPR1r81zYKk5jECEx7tGdEosp0Fg
         MkgsCnbz3afvEdXiorrrN7XGxPuCZ8Tn/CRm6/fwwDrlsm9nAgSPecbMLEkq2ngOTEpa
         AhHXRtmoTZ4ztbyXOSw8KEA0+1WxQ/u23ng67FYK6Ocd1AIEOzfjXeU2ReWBJFI4cTRH
         1cjGKzmvr173VaNyLvtKFWKuib8OqLYeFobUWugt3NzU8+Cmj2drBxAXFG4QdobfJnRf
         i4pw==
X-Gm-Message-State: AOJu0Yy4Gqy4v3CKrXIxZui0B3yGEaeziiiTzaUj5+zrX+nD8lq8q/IC
	t0d05zdrGfO4oBlGZzCGOwv0ZnXhN0r/sdvg8xj1a+JiDJXZKLmuFo9Gzy1tT9NiRcsPJcqf1b4
	+SqYoh8u5Gm39oNDvtWliX53OjfQkgWtEr5CS
X-Gm-Gg: ASbGncvwhUMtpQ0O9+pebVAGAfqtTydMgCDMpKosG5cpSEkEPSSCIr8ADmP00ELz5Ww
	y3+95MGrNtMb/W8p0M+ToXN3pfyIuMv8HJ0H7ZHj/7gsDalGZ6I90R1jH0S9luoMw8wR/Z163da
	KkFkfzgiW4V+rz11kLVWJbGp/tXcdUKrHiZNnohpfD+eMvElzI79h4bsfacyyspA==
X-Google-Smtp-Source: AGHT+IFA8MU+42zknu7gDNBHeojsKjV9uDa1jnChdduWJITNEf45prOiWI5Se4vMVbYxoLyrW/Hqzm7RsYnviEGtD/I=
X-Received: by 2002:a05:6e02:339e:b0:3d9:2425:b7e8 with SMTP id
 e9e14a558f8ab-3d96f212bfdmr1553395ab.12.1746054829762; Wed, 30 Apr 2025
 16:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429065132.36839-1-adityab1@linux.ibm.com>
In-Reply-To: <20250429065132.36839-1-adityab1@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Apr 2025 16:13:37 -0700
X-Gm-Features: ATxdqUHQNswL4T4QiBGFD92SCpJU0nTfW8iKRuSkSI6W_wyqcM7TywAO_UA4Ztk
Message-ID: <CAP-5=fXOyT30o5JdAer0hPnQZNgGtRKO6B0LWy_Sn-WYC+yM4A@mail.gmail.com>
Subject: Re: [PATCH v3] perf script: perf script tests fails with segfault
To: Aditya Bodkhe <adityab1@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Disha Goel <disgoel@linux.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:52=E2=80=AFPM Aditya Bodkhe <adityab1@linux.ibm.=
com> wrote:
>
> From: Aditya Bodkhe <aditya.b1@linux.ibm.com>
>
> perf script: pert script tests fails with segmentation fault as below:
>
>  92: perf script tests:
>  --- start ---
> test child forked, pid 103769
> DB test
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpO=
zX/perf.data (9 samples) ]
> /usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentatio=
n fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
>  --- Cleaning up ---
>  ---- end(-1) ----
>         92: perf script tests                                            =
   : FAILED!
>
> Backtrace pointed to :
>         #0  0x0000000010247dd0 in maps.machine ()
>         #1  0x00000000101d178c in db_export.sample ()
>         #2  0x00000000103412c8 in python_process_event ()
>         #3  0x000000001004eb28 in process_sample_event ()
>         #4  0x000000001024fcd0 in machines.deliver_event ()
>         #5  0x000000001025005c in perf_session.deliver_event ()
>         #6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
>         #7  0x0000000010251618 in perf_session.process_events ()
>         #8  0x0000000010053620 in cmd_script ()
>         #9  0x00000000100b5a28 in run_builtin ()
>         #10 0x00000000100b5f94 in handle_internal_command ()
>         #11 0x0000000010011114 in main ()
>
> Further investigation reveals that this occurs in the `perf script tests`=
,
> because it uses `db_test.py` script. This script sets `perf_db_export_mod=
e =3D True`.
>
> With `perf_db_export_mode` enabled, if a sample originates from a hypervi=
sor,
> perf doesn't set maps for "[H]" sample in the code. Consequently, `al->ma=
ps` remains NULL
> when `maps__machine(al->maps)` is called from `db_export__sample`.
>
> As al->maps can be NULL in case of Hypervisor samples , use thread->maps
> because even for Hypervisor sample, machine should exist.
> If we don't have machine for some reason, return -1 to avoid segmentation=
 fault.
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> Changelog:
> v2 -> v3:
> This patch contains changes suggested by Adrian Hunter<adrian.hunter@inte=
l.com> to add extra spaces
> before ---start--- and ---end---
> to be able to apply patch without any issues
>
> v1 -> v2:
> The below patch contains changes suggested by Adrian Hunter<adrian.hunter=
@intel.com> to handle the segmentation fault ,
> as well as initialisation of al.thread
>
>  tools/perf/util/db-export.c                           | 11 ++++++++---
>  .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index 50f916374d87..8f52e8cefcf3 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, stru=
ct addr_location *al,
>         if (al->map) {
>                 struct dso *dso =3D map__dso(al->map);
>
> -               err =3D db_export__dso(dbe, dso, maps__machine(al->maps))=
;
> +               err =3D db_export__dso(dbe, dso, maps__machine(thread__ma=
ps(al->thread)));

Would it be better to add a new helper function to minimize the chance
of a segv, like:
```
struct machine *addr_location__machine(struct addr_location *al)
{
  struct machine *machine =3D NULL;
  struct maps *maps =3D al->maps;

  if (maps)
    machine =3D maps__machine(maps)
  if (!machine && al->thread) {
    maps =3D thread__maps(al->thread);
    if (maps)
      machine =3D maps__machine(maps)
 }
  return machine;
}
```
>                 if (err)
>                         return err;
>                 *dso_db_id =3D dso__db_id(dso);
> @@ -256,6 +256,7 @@ static struct call_path *call_path_from_sample(struct=
 db_export *dbe,
>                 al.map =3D map__get(node->ms.map);
>                 al.maps =3D maps__get(thread__maps(thread));
>                 al.addr =3D node->ip;
> +               al.thread =3D thread__get(thread);
>
>                 if (al.map && !al.sym)
>                         al.sym =3D dso__find_symbol(map__dso(al.map), al.=
addr);
> @@ -358,14 +359,18 @@ int db_export__sample(struct db_export *dbe, union =
perf_event *event,
>         };
>         struct thread *main_thread;
>         struct comm *comm =3D NULL;
> -       struct machine *machine;
> +       struct machine *machine =3D NULL;
>         int err;
>
> +       if (thread__maps(thread))
> +               machine =3D maps__machine(thread__maps(thread));
> +       if (!machine)
> +               return -1;
> +

Perhaps the machine should be stashed somewhere like struct db_export ?

Thanks,
Ian

>         err =3D db_export__evsel(dbe, evsel);
>         if (err)
>                 return err;
>
> -       machine =3D maps__machine(al->maps);
>         err =3D db_export__machine(dbe, machine);
>         if (err)
>                 return err;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
> index 520729e78965..00f2c6c5114d 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1306,7 +1306,7 @@ static void python_export_sample_table(struct db_ex=
port *dbe,
>
>         tuple_set_d64(t, 0, es->db_id);
>         tuple_set_d64(t, 1, es->evsel->db_id);
> -       tuple_set_d64(t, 2, maps__machine(es->al->maps)->db_id);
> +       tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->=
db_id);
>         tuple_set_d64(t, 3, thread__db_id(es->al->thread));
>         tuple_set_d64(t, 4, es->comm_db_id);
>         tuple_set_d64(t, 5, es->dso_db_id);
> --
> 2.43.0
>
>
>
