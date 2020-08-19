From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: Scheduler benchmarks
Date: Wed, 19 Aug 2020 10:21:50 +0000
Message-ID: <4a20a4bb-0bc7-edb1-bd27-217d8dafe87c@petrovitsch.priv.at>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
 <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7CFE939DF1E22D7C4FEBF2B7"
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, peter enderborg <peter.enderborg@sony.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-perf-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------7CFE939DF1E22D7C4FEBF2B7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/08/2020 10:16, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 11:45 PM peter enderborg
> <peter.enderborg@sony.com> wrote:
[...]
>> On the 4.4 kernel you dont have
>>
>> +CONFIG_RETPOLINE=3Dy
>> +CONFIG_INTEL_RDT=3Dy
> Thanks! That is helpful. Yes, I see 4.4 kernel don't have the above
> two config options.
> What analysis can be done to narrow down the root cause?
> Any example of reference could be helpful to understand.

I haven't checked the date of the older kernel but Spectre+
Meltdown mitigation costs a lot (20%-30% speed IIRC, out
of the top of my head).

MfG,
	Bernd
--=20
There is no cloud, just other people computers.
-- https://static.fsf.org/nosvn/stickers/thereisnocloud.svg

--------------7CFE939DF1E22D7C4FEBF2B7
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lyN9df2R4qM7JHa5IGK2t9DC65Ur+0E7EEckVQ=3D=3D
=3DOPxp
-----END PGP PUBLIC KEY BLOCK-----

--------------7CFE939DF1E22D7C4FEBF2B7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--------------7CFE939DF1E22D7C4FEBF2B7--
