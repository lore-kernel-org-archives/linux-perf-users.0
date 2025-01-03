Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B451957FF
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735887006; cv=none; b=cLTAzR8DSv4R7XsCLV+VpsTGbDUck9R7LiMol3hMp1EZ5HBbGSC5327u9/P2pX0L6I225UDNegu/EMwPQXEeUXss4p68wFg7y74GSUZQwIut4vej6qQt5bQAltSJLMTjMHUqN3OIgrvxy7i5p+O6aR8X1BRZYtkymzvtbUpM9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735887006; c=relaxed/simple;
	bh=bWP2dXtYnXSRjovphjG8Vz7LIxoUuMBViNQKUStXf3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+hc+zh14olm43wDz0ZmowURP1gZthUjevDL54OOOW3CR6HKr/pvdyBFI5mvEtWALp+Ihs8Fbb2+KmwxCsmlJwrCbmZfniiEjqNWez4jU3hCZ8S4Uh7K6x36xUWBUn05qI1F4USPYbWbAwNu9RUzcErukDcvzrxhFMrV95L/xhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YPYgQ1KdGz9shx;
	Fri,  3 Jan 2025 07:33:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqkYK1XE_Yz2; Fri,  3 Jan 2025 07:33:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YPYgQ081cz9shw;
	Fri,  3 Jan 2025 07:33:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E06A28B767;
	Fri,  3 Jan 2025 07:33:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Fdm7xv9Pyy9L; Fri,  3 Jan 2025 07:33:37 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 78FF98B763;
	Fri,  3 Jan 2025 07:33:37 +0100 (CET)
Message-ID: <093e52e9-0441-4b61-9076-fb9622a9c450@csgroup.eu>
Date: Fri, 3 Jan 2025 07:33:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: James Clark <james.clark@linaro.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org> <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu> <Z3bYltoidQpqtyJ_@x1>
 <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu> <Z3c4nupM-UENN5LM@x1>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z3c4nupM-UENN5LM@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/01/2025 à 02:08, Arnaldo Carvalho de Melo a écrit :
>> Here is the output with -vv of the one that fails:
>>
>> Using CPUID 0x80840011
>> Problems creating module maps, continuing anyway...
> 
> This one: comes from here:
> 
>          if (symbol_conf.use_modules && machine__create_modules(machine) < 0) {
>                  if (machine__is_host(machine))
>                          pr_debug("Problems creating module maps, "
>                                   "continuing anyway...\n");
>                  else
>                          pr_debug("Problems creating module maps for guest %d, "
>                                   "continuing anyway...\n", machine->pid);
>          }
> 
> static int machine__create_modules(struct machine *machine)
> {
>          const char *modules;
>          char path[PATH_MAX];
>                     
>          if (machine__is_default_guest(machine)) {
>                  modules = symbol_conf.default_guest_modules;
>          } else {
>                  snprintf(path, PATH_MAX, "%s/proc/modules", machine->root_dir);
>                  modules = path;
>          }
>                          
>          if (symbol__restricted_filename(modules, "/proc/modules"))
>                  return -1;
> 
>          if (modules__parse(modules, machine, machine__create_module))
>                  return -1;
> 
>          if (!machine__set_modules_path(machine))
>                  return 0;
>                  
>          pr_debug("Problems setting modules path maps, continuing anyway...\n");
> 
>          return 0;
> }
> 
> 
> problems parsing /proc/modules?
> 
> symbol__restricted_filename() didn't change since 2012
> 
> modules__parse() also didn't have recent changes :-\
> 
> Maybe these messages are just red herrings...
> 

The kernel is built without CONFIG_MODULES

> I'm just ABENDing, to use a term a relative that is a brazilian bank
> manager complaining about some internal systems mentioned as being
> utterly irritating and that I found revealing about my age :-P
> 
> I'll try to continue tomorrow :-)
> 
> Off to bed!
> 
> - Arnaldo
