From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH -next] tools build: Check return value of fwrite_unlocked in jvmti_agent.c
Date: Wed, 29 Jul 2020 22:12:46 -0300
Message-ID: <F549EBCC-2BC0-43D4-B470-A53E9DF37A29@gmail.com>
References: <20200724100706.48330-1-bobo.shaobowang@huawei.com> <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: cj.chengjian@huawei.com, Li Bin <huawei.libin@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org



On July 29, 2020 8:47:36 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> w=
rote:
>On Fri, Jul 24, 2020 at 3:07 AM Wang ShaoBo
><bobo=2Eshaobowang@huawei=2Ecom> wrote:
>>
>> Function jvmti_write_code called by compiled_method_load_cb may
>return
>> error in using fwrite_unlocked, this failure should be captured and
>> warned=2E
>>
>> Signed-off-by: Wang ShaoBo <bobo=2Eshaobowang@huawei=2Ecom>
>> ---
>>  tools/perf/jvmti/jvmti_agent=2Ec | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/jvmti/jvmti_agent=2Ec
>b/tools/perf/jvmti/jvmti_agent=2Ec
>> index 88108598d6e9=2E=2Ea1fe6aa16b6d 100644
>> --- a/tools/perf/jvmti/jvmti_agent=2Ec
>> +++ b/tools/perf/jvmti/jvmti_agent=2Ec
>> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>>         struct jr_code_load rec;
>>         size_t sym_len;
>>         FILE *fp =3D agent;
>> -       int ret =3D -1;
>> +       int ret;
>>
>>         /* don't care about 0 length function, no samples */
>>         if (size =3D=3D 0)
>> @@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
>>         rec=2Ecode_index =3D code_generation++;
>>
>>         ret =3D fwrite_unlocked(&rec, sizeof(rec), 1, fp);
>> -       fwrite_unlocked(sym, sym_len, 1, fp);
>> +       if (ret)
>> +               goto error;
>
>Sorry, it seems I lost a reply to this=2E Won't ret here be the number
>of items written and not an error code? Consequently all writes will
>immediately goto error?

Good thing this is in tmp=2Eperf/core, you're right, the test has to be (r=
et < 0)=2E=2E=2E I'll fix, thanks!

Also we need some 'perf test' for this :-/

- Arnaldo
>
>Thanks,
>Ian
>
>> +       ret =3D fwrite_unlocked(sym, sym_len, 1, fp);
>> +       if (ret)
>> +               goto error;
>>
>> -       if (code)
>> -               fwrite_unlocked(code, size, 1, fp);
>> +       if (code) {
>> +               ret =3D fwrite_unlocked(code, size, 1, fp);
>> +               if (ret)
>> +                       goto error;
>> +       }
>>
>>         funlockfile(fp);
>> -
>> -       ret =3D 0;
>> -
>> -       return ret;
>> +       return 0;
>> +error:
>> +       funlockfile(fp);
>> +       return -1;
>>  }
>>
>>  int
>> --
>> 2=2E17=2E1
>>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
