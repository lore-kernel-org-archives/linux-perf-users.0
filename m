From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 0/3] btrfs: Performance profiler support
Date: Thu, 7 Mar 2019 22:18:49 +0800
Message-ID: <ccf67c41-752a-6812-0de7-34f39c37ecac@gmx.com>
References: <20190306061907.29685-1-wqu@suse.com>
 <20190307140223.GH31119@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9admczCrZXQYsWFnlc7unTAkQqLQmNERO"
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <20190307140223.GH31119@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9admczCrZXQYsWFnlc7unTAkQqLQmNERO
Content-Type: multipart/mixed; boundary="KEZOQGrqHSNxk9QW8Tb0HfEHsTTcbmmZG";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Message-ID: <ccf67c41-752a-6812-0de7-34f39c37ecac@gmx.com>
Subject: Re: [PATCH RFC 0/3] btrfs: Performance profiler support
References: <20190306061907.29685-1-wqu@suse.com>
 <20190307140223.GH31119@twin.jikos.cz>
In-Reply-To: <20190307140223.GH31119@twin.jikos.cz>

--KEZOQGrqHSNxk9QW8Tb0HfEHsTTcbmmZG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/3/7 =E4=B8=8B=E5=8D=8810:02, David Sterba wrote:
> On Wed, Mar 06, 2019 at 02:19:04PM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/perf_tree_lock
>> Which is based on v5.0-rc7 tag.
>>
>> Although we have ftrace/perf to do various performance analyse, under =
most
>> case the granularity is too small, resulting data flood for users.
>>
>> This RFC patchset provides a btrfs specific performance profiler.
>> It calculates certain function duration and account the duration.
>>
>> The result is provided through RO sysfs interface,
>> /sys/fs/btrfs/<FSID>/profiler.
>>
>> The content of that file is genreated when read.
>> Users can have full control on the sample resolution.
>>
>> The example content can be found in the last patch.
>>
>> One example using the interface to profile fsstress can be found here:=

>> https://docs.google.com/spreadsheets/d/1BVng8hqyyxFWPQF_1N0cpwiCA6R3SX=
tDTHmRqo8qyvo/edit?usp=3Dsharing
>>
>> The test script can be found here:
>> https://gist.github.com/adam900710/ca47b9a8d4b8db7168b261b6fba71ff1
>>
>> The interesting result from the graph is:
>> - Concurrency on fs tree is only high for the initial 25 seconds
>>   My initial expectation is, the hotness on fs tree should be more or
>>   less stable. Which looks pretty interesting
>>
>> - Then extent tree get more concurrency after 25 seconds
>>   This again breaks my expectation. As write to extent tree should onl=
y
>>   be triggered by delayed ref. So there is something interesting here
>>   too.
>>
>> - Root tree is pretty cold
>>   Since the test is only happening on fs tree, it's expected to be les=
s
>>   racy.
>>  =20
>> - There is some minor load on other trees.
>>   My guess is, that's from csum tree.
>>
>> Although the patchset is relatively small, there are some design point=
s
>> need extra commends before the patchset get larger and larger.
>>
>> - How should this profiler get enabled?
>>   Should this feature get enabled by mount option or kernel config?
>>   Or just let it run for all kernel build?
>>   Currently the overhead should be pretty small, but the overhead shou=
ld
>>   be larger and larger with new telemetry.
>>
>> - Design of the interface
>>   Is this a valid usage of sysfs or an abuse?
>>   And if the content can be improved for both human or program?
>=20
> Well, most of that is answered by 'figure out how to use tracepoints an=
d
> perf for that'.
>=20
> If there were not a whole substystem, actively maintained and
> documented, implementing something like that might help, but that's not=

> the case.
>=20
> I see what you were able to understand from the results, but it's more
> like a custom analysis tool that should not merged as-is. It brings a
> whole new interface and that's always hard to get right with all the
> mistakes ahead that somebody has probably solved already.
>=20
> It would be good to have list of the limitations of perf you see, and w=
e
> can find a solution ourselves or ask elsewhere.

Add linux-perf-users mail list.

I should mention the problem of ftrace (or my perf skill) in cover letter=
=2E

The biggest problem is the conflicts between detailed function execution
duration and classification.

For tree lock case, indeed we can use function graph to get execution
duration of btrfs_tree_read_lock() and btrfs_tree_lock().
But that's all. We can't really do much classification.

If just use trace event, with trace event added, then we can't get the
execution duration.

Even we can get both (my poor perf/ftrace skill must be blamed), it may
take some more time to get an easy graph.
We need to classify the result by eb owner, then account the execution
duration compared to the timestamp.

If perf users could provide better solution, I'm pretty willing to learn
some new tricks.
(Considering my poor perf skill is mostly from that LWN article, it
won't be a surprise for some perf black magic beating my hack).


And for the interface, that's why I send the patchset early to get some
feedback.
I'm really a bad interface designer.

Thanks,
Qu


--KEZOQGrqHSNxk9QW8Tb0HfEHsTTcbmmZG--

--9admczCrZXQYsWFnlc7unTAkQqLQmNERO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlyBKEkACgkQwj2R86El
/qj5dAf+Jgr80Q/N8d6xHoze5LDdkrtOSBatd4ZJOGBS+zRs2UC91Fh2dCF39Qez
SWLrdB7BF+66jq37La6peh/cloNgdbORSmRbFMG0v84C5pLlnH6NJax5pfis2qj2
YXvbfRO9sLMqd/LjqjIHy3AsI4CukusS18sq57Dz2u5SfWqz7V//PMVMrM0nW1lZ
3jmJ7wmADF4htyqhBr4VZUZpp9BcMczy2c8Zxp+RcRy4CdfADCWaZkouCVCNRvS4
hrfOIV6QYxXbf+KyHLZOrqepZjCyc99UXv5Jv3bfN0tIC1kUEtivo+RAs/pnwAUT
D4EXSvRzycCwpKEA9cJsUJS9cvyi3Q==
=PTei
-----END PGP SIGNATURE-----

--9admczCrZXQYsWFnlc7unTAkQqLQmNERO--
