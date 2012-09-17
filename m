From: liang xie <xieliang007@gmail.com>
Subject: Re: [PATCH v3] memory leak fix while calling system_path
Date: Mon, 17 Sep 2012 16:40:03 +0800
Message-ID: <CADu=CFpeZeQSYT9y0LEGarkGLBbuQH5cJ3T2n5v47B1X3Htkag@mail.gmail.com>
References: <CADu=CFrGDZ7waQbigcm43_Jm0NE2BAnmr0263iNAm-=A8erwBA@mail.gmail.com>
	<87haqx8fy1.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35129 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab2IQIkE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Sep 2012 04:40:04 -0400
Received: by dady13 with SMTP id y13so748969dad.19
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Sep 2012 01:40:03 -0700 (PDT)
In-Reply-To: <87haqx8fy1.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, balbi@ti.com, a.p.zijlstra@chello.nl, mingo@elte.hu, paulus@samba.org

On Mon, Sep 17, 2012 at 11:51 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> Hi,
>
> On Fri, 14 Sep 2012 11:14:13 +0800, liang xie wrote:
>> memory leak fix while calling system_path
>>
>> Since v1: Remove an unnecessary null pointer check per Felipe's comments
>> Since v2: Make system_path&perf_exec_path always return dynamically
>> allocated string
>>
>> Signed-off-by: xieliang <xieliang@xiaomi.com>
>> ---
>>  tools/perf/builtin-help.c   |   12 +++++++++---
>>  tools/perf/builtin-script.c |   13 ++++++++++---
>>  tools/perf/perf.c           |    8 ++++++--
>>  tools/perf/util/config.c    |   16 +++++-----------
>>  tools/perf/util/exec_cmd.c  |   26 +++++++++++++++-----------
>>  tools/perf/util/exec_cmd.h  |    4 ++--
>>  tools/perf/util/help.c      |    6 ++++--
>>  7 files changed, 51 insertions(+), 34 deletions(-)
>>
>> diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
>> index 6d5a8a7..180a5bd 100644
>> --- a/tools/perf/builtin-help.c
>> +++ b/tools/perf/builtin-help.c
>> @@ -321,12 +321,13 @@ static void setup_man_path(void)
>>  {
>>       struct strbuf new_path = STRBUF_INIT;
>>       const char *old_path = getenv("MANPATH");
>> +     char *man_path = system_path(PERF_MAN_PATH);
>
> I think the return value of system_path and perf_exec_path should be
> checked since they can return NULL as strdup() does.
Thanks, will modify at patch v4
>
>
> [snip]
>> diff --git a/tools/perf/util/exec_cmd.c b/tools/perf/util/exec_cmd.c
>> index 7adf4ad..1ace941 100644
>> --- a/tools/perf/util/exec_cmd.c
>> +++ b/tools/perf/util/exec_cmd.c
>> @@ -9,17 +9,19 @@
>>  static const char *argv_exec_path;
>>  static const char *argv0_path;
>>
>> -const char *system_path(const char *path)
>> +char *system_path(const char *path)
>>  {
>> -     static const char *prefix = PREFIX;
>> -     struct strbuf d = STRBUF_INIT;
>> +     char *new_path = NULL;
>>
>>       if (is_absolute_path(path))
>> -             return path;
>> +             return strdup(path);
>>
>> -     strbuf_addf(&d, "%s/%s", prefix, path);
>> -     path = strbuf_detach(&d, NULL);
>> -     return path;
>> +     new_path = malloc((strlen(PREFIX) + strlen(path) + 2));
>> +     if (!new_path)
>> +             die("malloc");
>> +
>> +     sprintf(new_path, "%s/%s", PREFIX, path);
>> +     return new_path;
>
> AFAIK strbuf allocates memory internally, so why this code is needed?
Make them always malloc, so we can free immediately after call
>
> Thanks,
> Namhyung
