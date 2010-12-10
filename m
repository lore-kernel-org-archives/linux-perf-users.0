From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Fri, 10 Dec 2010 14:00:01 +0100
Message-ID: <m3lj3xye9a.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m2k4jiewhi.fsf@gmail.com>
	<4D019E3F.4040902@hitachi.com> <m3pqtaxdv8.fsf@gmail.com>
	<4D01E453.3000208@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64220 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab0LJNAI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Dec 2010 08:00:08 -0500
Received: by wyb28 with SMTP id 28so3413302wyb.19
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2010 05:00:06 -0800 (PST)
In-Reply-To: <4D01E453.3000208@hitachi.com> (Masami Hiramatsu's message of
	"Fri, 10 Dec 2010 17:26:59 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, Francis Moreau <francis.moro@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> writes:

> (2010/12/10 16:53), Franck Bui-Huu wrote:

[...]

>> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
>> index 694f04b..558545e 100644
>> --- a/tools/perf/util/probe-event.c
>> +++ b/tools/perf/util/probe-event.c
>> @@ -114,6 +114,8 @@ static struct symbol *__find_kernel_function_by_name(const char *name,
>>  const char *kernel_get_module_path(const char *module)
>>  {
>>  	struct dso *dso;
>> +	struct map *map;
>> +	const char *vmlinux_name;
>>  
>>  	if (module) {
>>  		list_for_each_entry(dso, &machine.kernel_dsos, node) {
>> @@ -123,14 +125,23 @@ const char *kernel_get_module_path(const char *module)
>>  		}
>>  		pr_debug("Failed to find module %s.\n", module);
>>  		return NULL;
>> -	} else {
>> -		dso = machine.vmlinux_maps[MAP__FUNCTION]->dso;
>> -		if (dso__load_vmlinux_path(dso,
>> -			 machine.vmlinux_maps[MAP__FUNCTION], NULL) < 0) {
>> -			pr_debug("Failed to load kernel map.\n");
>> -			return NULL;
>> -		}
>>  	}
>> +
>> +	map = machine.vmlinux_maps[MAP__FUNCTION];
>> +	dso = map->dso;
>> +
>> +	vmlinux_name = symbol_conf.vmlinux_name;
>> +	if (vmlinux_name) {
>> +		if (dso__load_vmlinux(dso, map, vmlinux_name, NULL) == 0)

BTW, the condition seems wrong, it should have been '<= 0', that is if
an error occured or no symbol was loaded.

>> +			goto found;
>> +		return NULL;
>> +	}
>> +
>> +	if (dso__load_vmlinux_path(dso, map, NULL) < 0) {

This one should be '<= 0' too, since if no symbol is loaded, the image
is probably wrong.

>> +		pr_debug("Failed to load kernel map.\n");
>> +		return NULL;
>> +	}
>> +
>
> Hmm, could you put these changes into an else block?
> Because this part is only for the kernel vmlinux, and
> not for modules.

Ok, I'll do that.

Thanks.
-- 
		Franck
