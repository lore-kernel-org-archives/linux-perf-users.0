Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D34E1C8
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807303; cv=none; b=DLl0RA+ooYfXk38LLpfTo+vuQOJ6krmwIBNStKCS9W8HnAHHGmWCeo0FNAr6LYMhOqHNgGuDEEENHU1ohvOsB4gSYfnw+4kSbUEx+PAEYAe6ucixJYYAfSMQAOyn9+XC2rhZ75uUjLup3/lKIhP4bxYfhqrGbB9DvDfD7Ovce3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807303; c=relaxed/simple;
	bh=sR7Efk6tuD552OGUyQfPxlvDhFiS1PZYECSnCY+hjNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0x64SQ+rJqTSRZQ4NyKaNQzbbtST3PBy+ZqK1LoVk1zWVTF3k7C1cMybOH8kddn3RzpJgHI4gfM6UAzHa70y04jQfpaf7dE4D00hg0u5NfS9fwG4jCCeYiS5A/vEmTH8sIOSJRk3D2+IGu1Yq/zsvdhrLianqjw86pTEFB/3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=oy92+FnZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="oy92+FnZ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3687ea0521cso4710932f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1721807300; x=1722412100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krtFy5Mi1BGgzBjcFadwjlZluEt4OAciNF2RWrAZwwg=;
        b=oy92+FnZsLdihTIJaZBkAV9xQQNfa0Q2FrVjWUeGUGhfeGCjA8vl0525H3jQ0WKahh
         JLG/Zax+OO1Zm2jo4/eQZjDAyAdpHatpOIEXgMk+9cYtKVNDhg6ozyq3ZDdoFhU7uY0Y
         kUrto2iaxvxCvYbbsXMfTjHsGMv/xZ67Wov26yg2QCLp96QR/jnpUNx/PKPTp6wmpfxv
         iAJknGt7TVD7oigcBdFAHmFcetvvp1IKdv8TaiTmH+Z2CT+6l4L4xzR0I9ZZdYubsxj5
         OBk/5yJmFX/KyI0wlLG9rUM2lSoTdsdrKROv4fevAq9WV22eJh5qhiX/TC/S3IPNLkrx
         MSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807300; x=1722412100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krtFy5Mi1BGgzBjcFadwjlZluEt4OAciNF2RWrAZwwg=;
        b=a1hDvX1KL6RBWev1LPCS5vWyjs9NEf0GnjuXY03N51GR9PPDXHOf3DmwBLrLz+WIFx
         OHRAqTNBd0Pqg5JTYoHK07KHyRZ3qW1DEylNls+3vt4Mbui993j3O8mpZ/YEPQUE/j+K
         13iUH/a1MGurNJZNrEcWuiFG3h5bWSoAy2q7mhoWfrOysNyqhlZwRnNIPrenyQ7AUS8G
         JStz9/j19PCqDU+ACel3aIwepIdO1z9NXEKDFJ//GrAqZ2DpAS1co4wavesaOThdOXTk
         VWJISrQIIeP/TEOCiSzSzVATwuSDXFGmJkexeN9VDi5q64IgaHDhNsF/5mtvjYClVZpn
         VQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu7QSibEv5LaQjn52XsCzzWItLCh+DdOZFhOlI61fISk80lYv8oDm4mOOHNYQcDxv14dDZ78TiK/23VKIXvUjBXw16mWTwXQJRaD/hMPynDA==
X-Gm-Message-State: AOJu0YwWUiDFTN4UqTpOHzUG8S0T8Q0kN1SJR+lJ9IXwuGfP7waWmYB/
	djCdqjhOL0B6QVE0416J+PfyBcNV2y6cn6wMIEUkpmVcy1ykKi59yGQzDj8B8Mg=
X-Google-Smtp-Source: AGHT+IHJYQKmvGS93G2a3BT112cIQewhqjoeTVHdu6Fi/DuqndkssZhc6yIX5rxIS/1BJpp+wY8/Zg==
X-Received: by 2002:a5d:6684:0:b0:368:3ef7:3929 with SMTP id ffacd0b85a97d-369f09bcef7mr1642716f8f.22.1721807299800;
        Wed, 24 Jul 2024 00:48:19 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f935dd55sm16759555e9.8.2024.07.24.00.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:48:19 -0700 (PDT)
Message-ID: <4dac0c08-8bd7-44d2-967e-3491d9dd953c@ursulin.net>
Date: Wed, 24 Jul 2024 08:48:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/i915/pmu: Lazy unregister
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
 <20240722210648.80892-7-lucas.demarchi@intel.com>
 <be3871bd-fc25-482e-b4d4-91afc4d5b5a5@ursulin.net>
 <xsuzfv4rzb4c25sibt5gjskn7xyfwf33wgwaw4nkz5jlnvl2ke@ekur5xvhec3z>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <xsuzfv4rzb4c25sibt5gjskn7xyfwf33wgwaw4nkz5jlnvl2ke@ekur5xvhec3z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/07/2024 16:30, Lucas De Marchi wrote:
> On Tue, Jul 23, 2024 at 09:03:25AM GMT, Tvrtko Ursulin wrote:
>>
>> On 22/07/2024 22:06, Lucas De Marchi wrote:
>>> Instead of calling perf_pmu_unregister() when unbinding, defer that to
>>> the destruction of i915 object. Since perf itself holds a reference in
>>> the event, this only happens when all events are gone, which guarantees
>>> i915 is not unregistering the pmu with live events.
>>>
>>> Previously, running the following sequence would crash the system after
>>> ~2 tries:
>>>
>>>     1) bind device to i915
>>>     2) wait events to show up on sysfs
>>>     3) start perf  stat -I 1000 -e i915/rcs0-busy/
>>>     4) unbind driver
>>>     5) kill perf
>>>
>>> Most of the time this crashes in perf_pmu_disable() while accessing the
>>> percpu pmu_disable_count. This happens because perf_pmu_unregister()
>>> destroys it with free_percpu(pmu->pmu_disable_count).
>>>
>>> With a lazy unbind, the pmu is only unregistered after (5) as opposed to
>>> after (4). The downside is that if a new bind operation is attempted for
>>> the same device/driver without killing the perf process, i915 will fail
>>> to register the pmu (but still load successfully). This seems better
>>> than completely crashing the system.
>>
>> So effectively allows unbind to succeed without fully unbinding the 
>> driver from the device? That sounds like a significant drawback and if 
>> so, I wonder if a more complicated solution wouldn't be better after 
>> all. Or is there precedence for allowing userspace keeping their paws 
>> on unbound devices in this way?
> 
> keeping the resources alive but "unplunged" while the hardware
> disappeared is a common thing to do... it's the whole point of the
> drmm-managed resource for example. If you bind the driver and then
> unbind it while userspace is holding a ref, next time you try to bind it
> will come up with a different card number. A similar thing that could be
> done is to adjust the name of the event - currently we add the mangled
> pci slot.

Yes.. but what my point was this from your commit message:

"""
The downside is that if a new bind operation is attempted for
the same device/driver without killing the perf process, i915 will fail
to register the pmu (but still load successfully).
"""

So the subsequent bind does not "come up with a different card number". 
Statement is it will come up with an error if we look at the PMU subset 
of functionality. I was wondering if there was precedent for that kind 
of situation.

Mangling the PMU driver name probably also wouldn't be great.

> That said, I agree a better approach would be to allow
> perf_pmu_unregister() to do its job even when there are open events. On
> top of that (or as a way to help achieve that), make perf core replace
> the callbacks with stubs when pmu is unregistered - that would even kill
> the need for i915's checks on pmu->closed (and fix the lack thereof in
> other drivers).
> 
> It can be a can of worms though and may be pushed back by perf core
> maintainers, so it'd be good have their feedback.

Yeah definitely would be essential.

Regards,

Tvrtko

>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>>  drivers/gpu/drm/i915/i915_pmu.c | 24 +++++++++---------------
>>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_pmu.c 
>>> b/drivers/gpu/drm/i915/i915_pmu.c
>>> index 8708f905f4f4..df53a8fe53ec 100644
>>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>>> @@ -1158,18 +1158,21 @@ static void free_pmu(struct drm_device *dev, 
>>> void *res)
>>>      struct i915_pmu *pmu = res;
>>>      struct drm_i915_private *i915 = pmu_to_i915(pmu);
>>> +    perf_pmu_unregister(&pmu->base);
>>>      free_event_attributes(pmu);
>>>      kfree(pmu->base.attr_groups);
>>>      if (IS_DGFX(i915))
>>>          kfree(pmu->name);
>>> +
>>> +    /*
>>> +     * Make sure all currently running (but shortcut on pmu->closed) 
>>> are
>>> +     * gone before proceeding with free'ing the pmu object embedded 
>>> in i915.
>>> +     */
>>> +    synchronize_rcu();
>>>  }
>>>  static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node 
>>> *node)
>>>  {
>>> -    struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), 
>>> cpuhp.node);
>>> -
>>> -    GEM_BUG_ON(!pmu->base.event_init);
>>> -
>>>      /* Select the first online CPU as a designated reader. */
>>>      if (cpumask_empty(&i915_pmu_cpumask))
>>>          cpumask_set_cpu(cpu, &i915_pmu_cpumask);
>>> @@ -1182,8 +1185,6 @@ static int i915_pmu_cpu_offline(unsigned int 
>>> cpu, struct hlist_node *node)
>>>      struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), 
>>> cpuhp.node);
>>>      unsigned int target = i915_pmu_target_cpu;
>>> -    GEM_BUG_ON(!pmu->base.event_init);
>>> -
>>>      /*
>>>       * Unregistering an instance generates a CPU offline event which 
>>> we must
>>>       * ignore to avoid incorrectly modifying the shared 
>>> i915_pmu_cpumask.
>>> @@ -1337,21 +1338,14 @@ void i915_pmu_unregister(struct 
>>> drm_i915_private *i915)
>>>  {
>>>      struct i915_pmu *pmu = &i915->pmu;
>>> -    if (!pmu->base.event_init)
>>> -        return;
>>> -
>>>      /*
>>> -     * "Disconnect" the PMU callbacks - since all are atomic 
>>> synchronize_rcu
>>> -     * ensures all currently executing ones will have exited before we
>>> -     * proceed with unregistration.
>>> +     * "Disconnect" the PMU callbacks - unregistering the pmu will 
>>> be done
>>> +     * later when all currently open events are gone
>>>       */
>>>      pmu->closed = true;
>>> -    synchronize_rcu();
>>>      hrtimer_cancel(&pmu->timer);
>>> -
>>>      i915_pmu_unregister_cpuhp_state(pmu);
>>> -    perf_pmu_unregister(&pmu->base);
>>>      pmu->base.event_init = NULL;
>>>  }
